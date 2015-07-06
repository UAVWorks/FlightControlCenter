/*!
 * @file FgAircraft.h
 *
 * @brief Aircraft abstraction of FlightGear's aircrafts
 *
 * @author Oleksii Aliakin (alex@nls.la)
 * @date Created Jan 04, 2015
 * @date Modified Jul 05, 2015
 */

#ifndef FGAIRCRAFT_H
#define FGAIRCRAFT_H

#include <memory>
#include <QObject>
#include <QJsonObject>
#include <QDebug>

class FgTransport;
class FgAutopilot;

class FgAircraft : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString callsign READ callsign)
    Q_PROPERTY(bool connected READ connected)
    Q_PROPERTY(QJsonObject params READ getParams NOTIFY paramsChanged)

public:
    explicit FgAircraft(const QString& sign, QObject *parent = 0);
    virtual ~FgAircraft();

    inline const QString callsign() const;
    inline qreal pitch() const;
    inline qreal roll() const;
    inline qreal yaw() const;
    inline const QJsonObject getParams() const;
    inline qreal ailerons() const;
    inline qreal elevator() const;
    inline bool connected() const;

    inline void setCallsign(const QString& newCallsign);
    inline void setConnected(bool _connected);

protected:
    QString m_Callsign   = "";
    qint32 m_Index       = -1;
    QJsonObject m_Params { };

    qreal m_Pitch     = 0.0; // deg
    qreal m_Roll      = 0.0; // deg
    qreal m_Yaw       = 0.0; // deg
    qreal m_Longitude = 0.0; // deg
    qreal m_Latitude  = 0.0; // deg
    qreal m_Altitude  = 0.0; // ft
    qreal m_Heading   = 0.0; // deg

    // controls
    qreal m_Ailerons = 0.0;
    qreal m_Elevator = 0.0;
    qreal m_Rudder   = 0.0;
    bool m_Connected = false;

signals:
    void paramsChanged();
    void onConnected();

public slots:
    virtual void onFdmDataChanged(const FgTransport &transport);
};

//
const QString FgAircraft::callsign() const
{
    return m_Callsign;
}

qreal FgAircraft::pitch() const
{
    return m_Pitch;
}

qreal FgAircraft::roll() const
{
    return m_Roll;
}

qreal FgAircraft::yaw() const
{
    return m_Yaw;
}

const QJsonObject FgAircraft::getParams() const
{
    return m_Params;
}

qreal FgAircraft::ailerons() const
{
    return m_Ailerons;
}

qreal FgAircraft::elevator() const
{
    return m_Elevator;
}

bool FgAircraft::connected() const
{
    return m_Connected;
}

void FgAircraft::setCallsign(const QString &newCallsign)
{
    qDebug() << m_Callsign << " -> " << newCallsign;
    m_Callsign = newCallsign;
}

void FgAircraft::setConnected(bool _connected)
{
    m_Connected = _connected;
}

#endif // FGAIRCRAFT_H