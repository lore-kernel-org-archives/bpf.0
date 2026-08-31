Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315F39A079
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202683; cv=pass; b=FAS+Jc6siAGE9iCVlPZ4qEuO/i5ksPrKYGlJJHHY8wBxTlQtdOPsNpATzTomPoZiL4Z9GjWBhCz6nuAcV+jklZlSiITBOzWU78VA/2ditxCQK9W0qn1i1e+h/kmfp6etSdoVsJW1X5FZ6BIXlxeMWj6sTt8Fs+Z6OKBJpl3GXn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202683; c=relaxed/simple;
	bh=wv794X0je2MXFrBUsCc89F7tpzsIhAnK5VsmtIF3URY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6sO4gveHhYKkNQGd8yCsPcB+j9zfXG/44LPHpZHbLi+xK5ycleXPsFzN6cjtF8UDVA0e1rneF8sOmpPHLMtXOIkSMh9n6FzkzvF3UQ3pCLNHX6RrQbL0QHUhQcy6qhGXFND4sCoQmlLc0GAsKqh2i7TvGnDOIBUEI3OgQBnD1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbbtYzOj; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbbtYzOj"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52eaeddc837so556301cf.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788202679; cv=none;
        d=google.com; s=arc-20260327;
        b=QbPeKv8oz3SuSUvETKqjgmcFbhGosykhqM+ZC2ux051WI5C3YWTTH2J+j/iaRqCmLb
         tH+/jKMxJPWwconXghzqJ7/xxWVVgxJD2sXWUuWPSBVbC7k33Vb0lEy2G5bgJToE4FCZ
         13gjElKHlUZMOQrfyNqQZCXrRazpil1gqenKHfTI2sNNFx9eqq0r+SyjHgif875JHbk1
         o4tYxJvPW1WWT9PrQmGhR1XuBD5hkDNgAprgxKYq/nWGEM+ZrO/RbBWDIMshxlftlq5r
         LF2QmkZfdfRZgkejP3GMRL1W8PzCXPLvofeSGNSUWLc6JaTbTFGlWKFCHLOY4E/7vM93
         XHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hXT4J+ER44UE5+XAWIQtyXWJsqWRzK2ug1m5A5TgmbA=;
        fh=H00p7v/JQrl/Alz4AcsQTCvrRLwdJDZuNgoQe8xeYwg=;
        b=UAew1sCl5c1PuSuKDs950Ts3z7883PwORKlCMkaaEBewJpFqv8Dy8Ei8B5pKF3Q5Mo
         8JNWq7nLauAOCwKc3r1YklVfELY56bGlobaPNAJ5/cYEvI9qGuCHK/0hcY9Y5bEaw4ra
         MW4YLCAEvL30/JN0zYitGUswXTuCinBH6gnDdPRu+hFMG4/E7KXGMVvLXy7I8Pw5JQxa
         zXT5F+pQUTeXBrb19BwpI9rtoq9416a4zBLJ2jwKis6BpY5DCo/v+/UoRSWskBzo5lGU
         jTyJe/G9ruaGQErem3xvkYi5r3RsHIMgbjf7P5G99AUJIKAzOZ1GgWXAoqoYxBaGW+uE
         arhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788202679; x=1788807479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXT4J+ER44UE5+XAWIQtyXWJsqWRzK2ug1m5A5TgmbA=;
        b=nbbtYzOjTvw9dkW8EjyOFduIwiiBOkFBUTKbt0rJbfkh2sbjUwYxwzr5qymj3UN/J3
         VPk5yPkUgXzfOqvyh4VQDG1LTpiP7N1AX3mjlEfG2JyxKEdBUyZCZy1ReTqTqux62XWH
         HIGELMc34ezon6wBSnPtUn2zAO9fuqIN7R7TWadAkzF6BSCXm1NDFu6JSf/Z9XdQbtuk
         /n7Fv09x8v0+Dhlls9ojv0kIZvU8D+XQbSiEp8jBU6Z5Hvsc6zm53kq5jpQkb1pAcckf
         WIT8EY0+7Jr4KO4cFtBERPRziT002HqzEBbX+E+VeJ7O8hV+OKNh22czbnrmccbLafWj
         u+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202679; x=1788807479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXT4J+ER44UE5+XAWIQtyXWJsqWRzK2ug1m5A5TgmbA=;
        b=fycXQNX3ZzHEql50Gx8uCOB6HjH2qHeB5HXch+yRs1uzokqE4Qzt5Kr5xAAuUDmss5
         q7hvGXxODT60mg10oLqQfUtTYY6EnctlPX9yzJ+7mgSsN9wsBisL8bNlylrX0QfoJYJa
         NVHccE7eQ10EBovYgQNk6q2UZ9ftEav1Zf1dt++E8WWk55yeh18rsHtBmhN6XagVoOXT
         zUgTdnuuSa4RsdnKtbprzxqF9S4g0xS5Npo6VXU6l78Y/FfsIi08YEPJ7LcxG2Jef7w8
         7hK+794viUnZOGuX1Gx+RTjUxIvY6zsIiWLZtvroIGBkqnwsGZPxxDDGskMJ6IlAX6XU
         l8MA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+LHXCUGxqnqiCBzFJgvGrfnSl32koOBTf6j9GWKiIteEumUhq/kSPgA05kB3oGmh9dxI=@vger.kernel.org
X-Gm-Message-State: AFuF++lgXK7nbo7NVUFVTS0Kctz/xWFN0WyakOj/ot5vHZPOVr1WngQo
	KyOJoKMaK/9tK+rcyasDvSX53uibidGm1JEYR7s6gfg7dq/nFYK/VxR3CoGCoSXjT39rZXVu4qc
	jy8g1ehMiSnRR79/oeFl0qxnczc8LkJwWRDLquXVg
X-Gm-Gg: AR+sD13pbVjcGHjon4Cw5l5YZaZOfJ5L1DomUeZpMuUExDBPKd9Q3OsY3czah2no309
	ZgjOkfKn/YPxj2aeEA1jfRGklgSwWKR+Fz9HjQvgnL67HNG07fCfhTif2R6nZA4WcA2fBRSEgmi
	Qym+c3knKheyFLdOjaP+JaxdJ9cQbZ3iSNcdznSdm0qg2QJULgtkIDMJgg7n5c/J/3F8t4j6Urg
	ypIQ82WpmU+b3HBnyuXoJmMp7sYLYpgSpopQCI0UJr/ZMZZZMLS2w19IZyF0rCkUbpvjGZO8WQ4
	SKY2QT/N3YwjcbJjoZqLShObj1SiF79D0aHlbU/M0MFWEeom8jRjSVa7wxd7umSj1M03pIB8IIu
	J9GM1y7wgwD9U/QoZl7CwC0jcO5p8C0tHI37+9Spw44TWwmCWweRjqre3cg==
X-Received: by 2002:a05:622a:10a:b0:52f:ae28:6aef with SMTP id
 d75a77b69052e-52fb973ea96mr323163081cf.36.1788202678235; Mon, 31 Aug 2026
 11:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apWz9rPcGMgYCKOR@volt-roccet-vm>
In-Reply-To: <apWz9rPcGMgYCKOR@volt-roccet-vm>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Aug 2026 20:57:46 +0200
X-Gm-Features: AcwNN1WWg46QB-7drA2zXTsJRUc8oYLjYohkpOQp9TQPqJ1M3OiEjm9XZbW9-Ow
Message-ID: <CANn89iKaXghXPHTQU1sQdNEyfT3RA5AR_gY9+FrhKx59GUVOBQ@mail.gmail.com>
Subject: Re: [PATCHv5 net-next] tcp: Add TCP ROCCET congestion control module.
To: Tim Fuechsel <t.fuechsel@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, fmancera@suse.de, ebiggers@kernel.org, 
	bpf@vger.kernel.org, Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:04=E2=80=AFPM Tim Fuechsel <t.fuechsel@gmx.de> wr=
ote:
>
> TCP ROCCET is an new congestion control algorithm based on TCP CUBIC
> that improves its overall performance in cellular networks. By its mode
> of function, CUBIC causes bufferbloat while it tries to detect the
> available throughput of a network path. This is particularly a problem
> with large buffers in mobile networks. A more detailed description and
> analysis of this problem caused by TCP CUBIC can be found in [1].
> TCP ROCCET addresses the bufferbloat problem by adding two additional
> metrics to detect bufferbloat. The first metric is the relative increase
> in RTT from its minimum, the srRTT. Here, bufferbloat can be detected
> when RTTs increase due to buffer filling. The second metric is the
> acknowledgment arrival rate sampled over 100ms intervals. If CUBIC
> increases the send rate or congestion window, and the acknowledgment
> arrival rate stays on the same level, the connection is limited by the
> bottleneck link's capacity. In such cases, ROCCET reduces the send rate
> to prevent bufferbloat. ROCCET uses a modified version of slow start
> rather than HyStart because HyStart is known to enter the congestion
> avoidance phase too early when used in cellular networks [2]. Therefore,
> ROCCET uses a combination of srRTT and the acknowledgment arrival rate to
> determine when to exit slow start. For the congestion avoidance phase,
> ROCCET relies on the srRTT and monitoring the send and received Bytes
> to detect the filling of the bottleneck buffer.
>
> In real-world mobile 5G NR measurements, TCP ROCCET achieves better
> performance than CUBIC and BBRv3, by maintaining similar throughput
> while reducing the latency. In stationary 5G NR scenarios, the performanc=
e
> is similar to that of BBRv3. More information about TCP ROCCET and
> measurement evaluations can be found here [3].
> For the version (2026-07-21) we provide additional performance
> evaluation regarding throughput, latency and bandwidth share [4].
>
> [1] https://doi.org/10.1109/VTC2023-Fall60731.2023.10333357
> [2] https://doi.org/10.1109/WMNC.2016.7543932
> [3] https://doi.org/10.23919/WONS68803.2026.11501781
> [4] http://go.lu-h.de/roccet-2026-07-21
>
> Signed-off-by: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
> Signed-off-by: Tim Fuechsel <t.fuechsel@gmx.de>

Hi Lukas, Tim,

Here is a AI review of your patch. There are several architectural issues,
race conditions, and logic bugs that need to be addressed.

1. Concurrency data race on module parameters in socket init
------------------------------------------------------------
In roccettcp_init():
    param_check(true);
    param_precompute();

Both functions mutate global static variables (beta, bic_scale, beta_scale,
cube_rtt_scale, cube_factor) that are marked __read_mostly.
Calling this in roccettcp_init() on every socket creation causes unsynchron=
ized
concurrent writes across CPUs. Furthermore, param_check() calls pr_err() /
pr_info(), which will spam the kernel log on every connection creation if a=
n
invalid parameter was configured.

Global scale factors should only be precomputed at module init time
(roccettcp_register), or validated using kernel_param_ops.


2. Bypassing PRR and broken loss recovery via .cong_control
----------------------------------------------------------
By defining .cong_control =3D roccet_control, TCP core completely delegates
congestion control and skips PRR (tcp_cwnd_reduction()).

However, in roccet_control():
    if (!ca->is_in_recovery)
        roccettcp_cong_avoid(sk, ack, rs->acked_sacked);

During recovery (TCP_CA_Recovery), ROCCET does nothing to regulate cwnd or
clock out retransmissions according to RFC 6937. Unless you have a full
custom recovery engine (like BBR), you should stick to .cong_avoid so the
stack handles PRR and loss recovery properly.


3. Broken .ssthresh callback and ignored ECN (TCP_CA_CWR)
---------------------------------------------------------
roccettcp_ssthresh() simply returns tp->snd_ssthresh without recalculation:
    static u32 roccettcp_ssthresh(struct sock *sk)
    {
        return tcp_sk(sk)->snd_ssthresh;
    }

The recalculation was moved to roccettcp_state(..., TCP_CA_Recovery).
This breaks the TCP stack contract:
a) tcp_init_cwnd_reduction() initializes PRR state using the return value o=
f
   icsk_ca_ops->ssthresh(sk). Returning the unreduced ssthresh corrupts PRR=
.
b) When ECN CE marks arrive, tcp_enter_cwr() transitions to TCP_CA_CWR and =
calls
   icsk_ca_ops->ssthresh(sk). Since roccettcp_state() only checks for Loss =
and
   Recovery, TCP_CA_CWR is completely ignored. Consequently, neither ssthre=
sh
   nor cwnd is ever reduced on ECN.


4. Congestion avoidance starvation in ORBITER
---------------------------------------------
In roccettcp_cong_avoid():
    send =3D tp->snd_nxt - ca->interval_snd_seq_start;
    received =3D tp->snd_una - ca->interval_una_seq_start;
    send_more_than_acked =3D
        send > received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100);
    ...
    if (!tcp_is_cwnd_limited(sk) || send_more_than_acked)
        return;

During steady-state transmission, the in-flight byte count (send - received=
)
is approximately cwnd * mss. This is ~100x larger than the 1% guard space
((cwnd * mss) / 100). Thus, send_more_than_acked evaluates to true on almos=
t
every ACK, returning before bictcp_update() or tcp_cong_avoid_ai() can run.
Window growth in congestion avoidance is completely starved.


5. curr_min_rtt poisoning and premature slow-start exit
-------------------------------------------------------
In roccettcp_reset(), ca->curr_rtt is 0 and ca->curr_min_rtt is ~0U.
In update_min_rtt():
    if (ca->curr_rtt < ca->curr_min_rtt) {
        ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
        ...

If an ACK arrives before an RTT sample is collected (e.g. sample->rtt_us <=
=3D 0),
ca->curr_rtt is 0. ca->curr_min_rtt is set to max(0, 1) =3D 1 us.
Because 1 us is smaller than any real path RTT, ca->curr_min_rtt remains st=
uck
at 1 us.
Then in update_srrtt():
    u32 rrtt =3D div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
                       ca->curr_min_rtt);
For a 20 ms RTT (20000 us), rrtt evaluates to 1,999,900. curr_srrtt immedia=
tely
exceeds sr_rtt_upper_bound and terminates slow start on the very first samp=
le.


6. Perpetual min-RTT probe loop
-------------------------------
In roccet_min_rtt_probe(), when the probe finishes:
    ca->probe_min_rtt_until =3D 0;
    ca->state =3D ORBITER;

ca->next_min_rtt_probe is not updated when exiting the probe. If no new low=
er
RTT was found during the probe, next_min_rtt_probe remains in the past.
On the next ACK, after(now, ca->next_min_rtt_probe) immediately evaluates t=
o
true, trapping the flow in a continuous probe loop and repeatedly halving c=
wnd
down to TCP_INIT_CWND.


7. 71-minute timestamp wrap and permanent DRAIN state
-----------------------------------------------------
now is calculated via jiffies_to_usecs(tcp_jiffies32), which wraps every
~71.5 minutes (2^32 us).

In roccet_control():
    else if ((s32)now - ca->roccet_last_event_time_us <=3D 100 * USEC_PER_M=
SEC)
        ca->state =3D DRAIN;

ca->roccet_last_event_time_us is initialized to 0. When bit 31 of now is se=
t
(for 35.7 minutes out of every 71.5 minutes), (s32)now is negative, so
(s32)now - 0 is negative and always <=3D 100000. Newly created connections =
during
that 35-minute window will immediately enter and remain permanently stuck i=
n
DRAIN state.

Also, before() and after() from <net/tcp.h> are sequence number comparison
macros (32-bit TCP seqno), not time comparison macros.


8. Re-implementing tcp_update_pacing_rate()
-------------------------------------------
roccet_control() duplicates the pacing rate calculation from tcp_input.c an=
d
hardcodes 100% pacing instead of honoring sysctl_tcp_pacing_ca_ratio. If yo=
u
switch to .cong_avoid, the core stack will manage pacing updates automatica=
lly.


9. Coding style & formatting
----------------------------
- Declarations after statements (ISO C90 violations) in roccettcp_init(),
  update_srrtt(), roccettcp_acked(), and roccettcp_register().
- C++ style comments (//) instead of /* ... */ in multiple places.
- Commented-out dead code: //WRITE_ONCE(sk->sk_pacing_rate, 0);
- Typos in comments ("sRrTT", "probeing", "has was idle", "defer", etc.)
  and references to non-existent struct fields ("curr_min_rtt_timed.rtt").

Thanks.
