Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335526FDBF
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627494; cv=none; b=FJr19WVcY8IWU7e/vhBifut7KG3JOspOHQBaN3hn14qfQW1fRe8dK+iUE9+B13L4B083W0D+wtG7FK/rxa9T0sUSpAZ7DYuLmil1ET8n+2jGNVPXKpQhG6cU4qz79lqoS2WIyaXK7W1r0ILFWdvdSpKhm9JvJGRNH/uXfHSMJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627494; c=relaxed/simple;
	bh=hbSu7tOGEfBy9jjU8G1pv4LeYSfXfiI56qnlALUxbiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHfRU7DXOYsB+be2AzmWm37zrh4qXRPrbBCr6EFtET5jYj5Ac/Ff5l1j7dbrFMgYbL6p13yztEZ/JtAVrY60af4y1sOYV8a4KzCWcMVOrV7YygbnfisbJ6XMSJ/2LBw+uKk7aKALY0DE2hB72Yid3xEB9OH5OTVR3c8VnN9MYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b=CWxfnRky; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=t.fuechsel@gmx.de header.b="CWxfnRky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791627484; x=1792232284; i=t.fuechsel@gmx.de;
	bh=hbSu7tOGEfBy9jjU8G1pv4LeYSfXfiI56qnlALUxbiw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CWxfnRky7PqSibkbF3GQSShn2bgdv+eq6Uv2jhjmaa5k90RyeB8ZkpAF8BNvrRDZ
	 snVcuoUkuvR+XMIkO+ynE16jV+LYTHarrbgw5mOpFhupjFCdTW53A93SsQDI836qn
	 YrMeN3nupW/HlthgmZ+pPfwgFJTFBImLvtT8sGgH3iTWFTSPnouce0ch6DOPCyYby
	 B6lQAaGLd7sRUxHulUIXQYmbn85uOoIPokCwnmsieb2EbV/+5PwDfy+f7PKeyDrY+
	 eT3isilJ1ciqxVU02jAjB3mkP7GfNd/l+nXpwkSE8VtOSam3NwXg6F65CvRy/1OzY
	 hXdIf01/+BEy5+64fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1wrj3V2DEn-00mbPY; Sat, 10
 Oct 2026 12:18:04 +0200
Message-ID: <7e9191f3-c68c-4f27-9c4b-4508f8627c7d@gmx.de>
Date: Sat, 10 Oct 2026 12:18:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 net-next] tcp: Add TCP ROCCET congestion control
 module.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Lukas Prause <lukas.prause@ikt.uni-hannover.de>
References: <asdfdDIQb7Nhm692@volt-roccet-vm>
 <sashiko-outbox-165144@kernel.org>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Tim_F=C3=BCchsel?= <t.fuechsel@gmx.de>
In-Reply-To: <sashiko-outbox-165144@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6rUlN9uteP/3AMCYy4pb9t+MYbMp7CDJXLsd4s29R0v2jxZkuHg
 sLEevzn1SL/ZW1+8ARXANQPCaY1NhlbVHbtOB0mf4gWXKDMecxT5TKDmVBGvmmFTbk5QxEJ
 77CquxobbHgyWa0ZvniPTkhr/vgOk4YblgqYvm8eSViQAd4b0JiXeaaulXWyUHZI/Z+Iips
 r4QHTPBx+eH8qH9DCiQPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k2tClptRfgc=;uhAWI7iMV0E/BiLUlxGxz3M8kU1
 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


Thanks for the review. We have some comments about the two mentioned issue=
s
and don't think any code changes are necessary.


 > > +static void roccet_orbiter_update(struct sock *sk, u32 acked)
 > > +{
 > [ ... ]
 > > +=C2=A0 =C2=A0 /* Enter RTT_PROBE when the "timer" has expired.
 > > +=C2=A0 =C2=A0 =C2=A0*
 > > +=C2=A0 =C2=A0 =C2=A0* Since we are in ORBITER, we should have alread=
y received at=20
least
 > > +=C2=A0 =C2=A0 =C2=A0* one RTT sample. However safeguard against it i=
f not.
 > > +=C2=A0 =C2=A0 =C2=A0*
 > > +=C2=A0 =C2=A0 =C2=A0* Use double the probing period as a guard space=
 to avoid
 > > +=C2=A0 =C2=A0 =C2=A0* idle-time locking us out of probing.
 > > +=C2=A0 =C2=A0 =C2=A0*/
 > > +=C2=A0 =C2=A0 if (!time_between32(now, ca->next_min_rtt_probe
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- 2 * =
ROCCET_NEXT_MIN_RTT_PROBE_MS
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* USEC=
_PER_MSEC, ca->next_min_rtt_probe) &&
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->curr_rtt !=3D U32_MAX) {
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->state =3D RTT_PROBE_ENTER;
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
 > > +=C2=A0 =C2=A0 }
 >
 > [Severity: Medium]
 > Could this condition falsely trigger a premature RTT probe if the=20
connection
 > was previously idle?
 >
 > In roccet_enter_min_rtt_probe(), ca->next_min_rtt_probe is assigned a r=
aw
 > jiffies timestamp to track the probe epoch. Normal state transitions=20
out of
 > probing explicitly reinitialize next_min_rtt_probe to a usecs timestamp=
.
 >
 > If the connection then enters ORBITER from LAUNCH, this block=20
compares a usecs
 > timestamp (now) against the residual jiffies timestamp. Since usecs=20
are vastly
 > larger, won't this check instantly fail and incorrectly re-enter probin=
g?

This is true, however, it won't cause any problems.
Since it makes sense to initiate a min RTT probe after an idle period,
this behavior is consistent with how the algorithm was designed.

 > [ ... ]
 > > +static void roccet_handle_state_transitions(struct sock *sk,
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 enum roccet_state prev_state,
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 u32 now)
 > > +{
 > [ ... ]
 > > +=C2=A0 =C2=A0 /* Whenever we leave the min RTT probing states (and n=
ot just
 > > +=C2=A0 =C2=A0 =C2=A0* transition between them), we want to reset the=
 probing timers.
 > > +=C2=A0 =C2=A0 =C2=A0*/
 > > +=C2=A0 =C2=A0 if ((prev_state =3D=3D RTT_PROBE_ENTER || prev_state =
=3D=3D RTT_PROBE ||
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prev_state =3D=3D RTT_PROBE_REFILL=
) &&
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ca->state !=3D RTT_PROBE && ca->state !=
=3D RTT_PROBE_REFILL)) {
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->probe_min_rtt_until =3D 0;
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->refill_until =3D 0;
 > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ca->rtt_probe_timers_set =3D false;
 > > +=C2=A0 =C2=A0 }
 > > +}
 >
 > [Severity: Medium]
 > When the connection goes idle during probing,=20
roccet_cwnd_event_tx_start()
 > forces an immediate transition to LAUNCH. This cleanup logic handles=20
clearing
 > the probe timers, but does it miss reinitializing next_min_rtt_probe=20
to usecs
 > for that transition?

Same as above. This will lead to a new min RTT probe after the LAUNCH phas=
e,
which is a desirable behaviour.

 > [ ... ]
 > > +static int __init roccet_register(void)
 > > +{
 > > +=C2=A0 =C2=A0 int param_err;
 > > +
 > > +=C2=A0 =C2=A0 BUILD_BUG_ON(sizeof(struct roccettcp) > ICSK_CA_PRIV_S=
IZE);
 >
 > [Severity: High]
 > Does this assertion fail unconditionally because the struct exceeds=20
104 bytes?
 >
 > struct roccettcp contains 24 u32 fields (96 bytes) and 3 u16 fields=20
(6 bytes),
 > consuming 102 bytes. The next field is the enum roccet_state=20
bitfield, which
 > forces 2 bytes of padding after the u16 fields, placing the bitfield=20
block at
 > offset 104, pushing the total struct size to 108 bytes.
 >
 > Since ICSK_CA_PRIV_SIZE is exactly 104 bytes, won't this break=20
compilation on
 > standard architectures?

Based on our understanding and compilation results, this is not the case.
The structure, including padding, is exactly 104 bytes in size.

