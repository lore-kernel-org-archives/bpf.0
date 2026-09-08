Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4A52BE5D;
	Tue,  8 Sep 2026 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.75.2.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866884; cv=none; b=pG6lvmzJzioCtZ19hyDylJ69Gycs1FwVfIAwAK6u/42XUP/oBUPwszvCQ4/zpRkR0XRHeAxUIHarOZmCxyXZm2OW3BxrEDMrMIUOBxuKr1C8FY+ARPMzygM9nAY27vgYs3tdvLS/lW9yTyJAD5ala9d5KzDvyahgH+BtsVTHoas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866884; c=relaxed/simple;
	bh=VcIxxv6slkv1OxSvzGA9rxW19CEqGVmwm0V7fqV+eI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xaul5cwE2CZ1zGSEwG+XCt91sIjtUL5uFW1rlz2LXDfe3Bb5E6CO3Fk4kwI6eKYMru8oRuqxL1W5wseK25KA9adzhHswDnQAcBxdn0BUy1sKG1FglJftoy0TsnYmweyRXPEKKWOS6vVSlMsUbkA7Rx2SZN1t+u6fnzuBbuMWesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de; spf=pass smtp.mailfrom=ikt.uni-hannover.de; dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b=eMAmUQrS; arc=none smtp.client-ip=130.75.2.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikt.uni-hannover.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b="eMAmUQrS"
Received: from [172.23.180.109] (gateway.ikt.uni-hannover.de [130.75.73.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id ADFE7F3F;
	Tue,  8 Sep 2026 13:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-hannover.de;
	s=2024all; t=1788866542;
	bh=VcIxxv6slkv1OxSvzGA9rxW19CEqGVmwm0V7fqV+eI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eMAmUQrSorUOu9LdCjF4mIG2A1Tp5n27nSWto0Tf/riU3NlyH0FNEypnrHjjVM2Lg
	 60h4ymSprxhfHKjgqh2N1ApAlAIDLgWzCT7p/eiCHY8xH6V6pCdAHrtP/oAvHwYCOq
	 c5uX7xhrjYwc2NzChmGQUFFyBi3EhIwqhL9bvEvu2eq3adL2pCpPNTjW4kkZhg3hr/
	 5Rb0Wl79e0vmyOtzGHTWceJKCQtI1orbSTh/EBgBWjLof8U2eBMjQ4oPUKWABskXjk
	 b3W0yOfkmEj1tttxdy2+z1sMvQaAjLCLmS419qWlE013563kbHq1NXEY3o2zEzuVJb
	 +9140cO5yvowg==
Message-ID: <cee2e4d2-3a0f-46d2-9607-b72eb95f785f@ikt.uni-hannover.de>
Date: Tue, 8 Sep 2026 13:22:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCHv5 net-next] tcp: Add TCP ROCCET congestion control
 module.
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, fmancera@suse.de,
 ebiggers@kernel.org, bpf@vger.kernel.org, Tim Fuechsel <t.fuechsel@gmx.de>
References: <apWz9rPcGMgYCKOR@volt-roccet-vm>
 <CANn89iKaXghXPHTQU1sQdNEyfT3RA5AR_gY9+FrhKx59GUVOBQ@mail.gmail.com>
Content-Language: de-DE
From: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
In-Reply-To: <CANn89iKaXghXPHTQU1sQdNEyfT3RA5AR_gY9+FrhKx59GUVOBQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms030801050306050308000503"
X-Virus-Scanned: clamav-milter 0.103.9 at mailout1n
X-Virus-Status: Clean

This is a cryptographically signed message in MIME format.

--------------ms030801050306050308000503
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thank you for the review. On a few points, I=E2=80=99d have some comments=
=2E We
think that this AI review is, at some point, a little bit misleading.
We are using the cong_control functionality to implement stricter packet
pacing than the default value.
With this, we aim to implement our own alternative to PRR.

> 1. Concurrency data race on module parameters in socket init
> ------------------------------------------------------------
> In roccettcp_init():
>     param_check(true);
>     param_precompute();
>
> Both functions mutate global static variables (beta, bic_scale,
beta_scale,
> cube_rtt_scale, cube_factor) that are marked __read_mostly.
> Calling this in roccettcp_init() on every socket creation causes
unsynchronized
> concurrent writes across CPUs. Furthermore, param_check() calls pr_err(=
) /
> pr_info(), which will spam the kernel log on every connection creation
if an
> invalid parameter was configured.
>
> Global scale factors should only be precomputed at module init time
> (roccettcp_register), or validated using kernel_param_ops.
I agree with you. We will fix that.

> 2. Bypassing PRR and broken loss recovery via .cong_control
> ----------------------------------------------------------
> By defining .cong_control =3D roccet_control, TCP core completely deleg=
ates
> congestion control and skips PRR (tcp_cwnd_reduction()).
>
> However, in roccet_control():
>     if (!ca->is_in_recovery)
>         roccettcp_cong_avoid(sk, ack, rs->acked_sacked);
>
> During recovery (TCP_CA_Recovery), ROCCET does nothing to regulate cwnd=
 or
> clock out retransmissions according to RFC 6937. Unless you have a full=

> custom recovery engine (like BBR), you should stick to .cong_avoid so t=
he
> stack handles PRR and loss recovery properly.
If we are in recovery we still do packet pacing to 100 percent of the
cwnd instead of 120.

> 3. Broken .ssthresh callback and ignored ECN (TCP_CA_CWR)
> ---------------------------------------------------------
> roccettcp_ssthresh() simply returns tp->snd_ssthresh without
recalculation:
>     static u32 roccettcp_ssthresh(struct sock *sk)
>     {
>         return tcp_sk(sk)->snd_ssthresh;
>     }
>
> The recalculation was moved to roccettcp_state(..., TCP_CA_Recovery).
> This breaks the TCP stack contract:
> a) tcp_init_cwnd_reduction() initializes PRR state using the return
value of
>    icsk_ca_ops->ssthresh(sk). Returning the unreduced ssthresh
corrupts PRR.
> b) When ECN CE marks arrive, tcp_enter_cwr() transitions to TCP_CA_CWR
and calls
>    icsk_ca_ops->ssthresh(sk). Since roccettcp_state() only checks for
Loss and
>    Recovery, TCP_CA_CWR is completely ignored. Consequently, neither
ssthresh
>    nor cwnd is ever reduced on ECN.
We are not using the PRR from the TCP stack, because we are implementing
cong_control.
I agree that ECNs are ignored here. We will fix that.

> 4. Congestion avoidance starvation in ORBITER
> ---------------------------------------------
> In roccettcp_cong_avoid():
>     send =3D tp->snd_nxt - ca->interval_snd_seq_start;
>     received =3D tp->snd_una - ca->interval_una_seq_start;
>     send_more_than_acked =3D
>         send > received + ((tcp_snd_cwnd(tp) * tp->mss_cache) / 100);
>     ...
>     if (!tcp_is_cwnd_limited(sk) || send_more_than_acked)
>         return;
>
> During steady-state transmission, the in-flight byte count (send -
received)
> is approximately cwnd * mss. This is ~100x larger than the 1% guard spa=
ce
> ((cwnd * mss) / 100). Thus, send_more_than_acked evaluates to true on
almost
> every ACK, returning before bictcp_update() or tcp_cong_avoid_ai() can
run.
> Window growth in congestion avoidance is completely starved.
That is not true. Here we are monitoring the bytes sent and received
over a time interval of 5 RTT

> 5. curr_min_rtt poisoning and premature slow-start exit
> -------------------------------------------------------
> In roccettcp_reset(), ca->curr_rtt is 0 and ca->curr_min_rtt is ~0U.
> In update_min_rtt():
>     if (ca->curr_rtt < ca->curr_min_rtt) {
>         ca->curr_min_rtt =3D max(ca->curr_rtt, 1);
>         ...
>
> If an ACK arrives before an RTT sample is collected (e.g.
sample->rtt_us <=3D 0),
> ca->curr_rtt is 0. ca->curr_min_rtt is set to max(0, 1) =3D 1 us.
> Because 1 us is smaller than any real path RTT, ca->curr_min_rtt
remains stuck
> at 1 us.
> Then in update_srrtt():
>     u32 rrtt =3D div_u64(100 * (u64)(ca->curr_rtt - ca->curr_min_rtt),
>                        ca->curr_min_rtt);
> For a 20 ms RTT (20000 us), rrtt evaluates to 1,999,900. curr_srrtt
immediately
> exceeds sr_rtt_upper_bound and terminates slow start on the very first
sample.
That could be a problem, and we will implement a fix for it.

> 6. Perpetual min-RTT probe loop
> -------------------------------
> In roccet_min_rtt_probe(), when the probe finishes:
>     ca->probe_min_rtt_until =3D 0;
>     ca->state =3D ORBITER;
>
> ca->next_min_rtt_probe is not updated when exiting the probe. If no
new lower
> RTT was found during the probe, next_min_rtt_probe remains in the past.=

> On the next ACK, after(now, ca->next_min_rtt_probe) immediately
evaluates to
> true, trapping the flow in a continuous probe loop and repeatedly
halving cwnd
> down to TCP_INIT_CWND.
That is not true. Every time a new minimum RTT is found, we calculate
ca->next_min_rtt_probe, and before we enter probing, the current minimum
RTT is set to u32 max.
This means the next RTT is the new minimum RTT.

> 7. 71-minute timestamp wrap and permanent DRAIN state
> -----------------------------------------------------
> now is calculated via jiffies_to_usecs(tcp_jiffies32), which wraps ever=
y
> ~71.5 minutes (2^32 us).
>
> In roccet_control():
>     else if ((s32)now - ca->roccet_last_event_time_us <=3D 100 *
USEC_PER_MSEC)
>         ca->state =3D DRAIN;
>
> ca->roccet_last_event_time_us is initialized to 0. When bit 31 of now
is set
> (for 35.7 minutes out of every 71.5 minutes), (s32)now is negative, so
> (s32)now - 0 is negative and always <=3D 100000. Newly created
connections during
> that 35-minute window will immediately enter and remain permanently
stuck in
> DRAIN state.
>
> Also, before() and after() from <net/tcp.h> are sequence number compari=
son
> macros (32-bit TCP seqno), not time comparison macros.
This is a problem, and we will fix it.
In the past, we got a hint that we should use the before and after
macros here.

> 8. Re-implementing tcp_update_pacing_rate()
> -------------------------------------------
> roccet_control() duplicates the pacing rate calculation from
tcp_input.c and
> hardcodes 100% pacing instead of honoring sysctl_tcp_pacing_ca_ratio.
If you
> switch to .cong_avoid, the core stack will manage pacing updates
automatically.
We do this as an alternative to PRR with stricter pacing.

> 9. Coding style & formatting
> ----------------------------
> - Declarations after statements (ISO C90 violations) in roccettcp_init(=
),
>   update_srrtt(), roccettcp_acked(), and roccettcp_register().
> - C++ style comments (//) instead of /* ... */ in multiple places.
> - Commented-out dead code: //WRITE_ONCE(sk->sk_pacing_rate, 0);
> - Typos in comments ("sRrTT", "probeing", "has was idle", "defer", etc.=
)
>   and references to non-existent struct fields ("curr_min_rtt_timed.rtt=
").
Of course, we will correct that.

--------------ms030801050306050308000503
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
DTswggZEMIIELKADAgECAhAV+a5sqo0u1NNveH8e3HsBMA0GCSqGSIb3DQEBCwUAMG8xCzAJ
BgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5z
dGl0dXRpb25zIENBMScwJQYDVQQDDB5IQVJJQ0EgQ2xpZW50IFJTQSBSb290IENBIDIwMjEw
HhcNMjUwMTAzMTExMzA4WhcNMzkxMjMxMTExMzA3WjBjMQswCQYDVQQGEwJHUjE3MDUGA1UE
CgwuSGVsbGVuaWMgQWNhZGVtaWMgYW5kIFJlc2VhcmNoIEluc3RpdHV0aW9ucyBDQTEbMBkG
A1UEAwwSR0VBTlQgUy9NSU1FIFJTQSAxMIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKC
AYEAq7hur/5vIqMejblfPfZgGY75auSZz5SZ9x1dIIjvJrDBT0lIwQcAAoABJomkuv0kDK36
2UH+uf9JrOdLBjiKkEh99HQPmT+d1+Ijnnd1aAjiL+2Q4aU16P/snITYJL2ROU46zqmDkdoO
nCqMCEKSN74gHKDmApYfqXO8wmjmNA62wYHarp7lxgrBr0sk4BxHyKq52z0sWyxsdIy5V1K5
OOkCNwYupZ9b74LRhelYP5SieNDqU0S6IpQOasVz5IS0vDnqVi2ni67Gbgtb8dBKzH6gbAwG
ppHoeEFDcvJ042Oxtxt6BGolkUmguyfAgeisRqDjhQi+NfNgkDH81OLBV0eV07twS9axwNvJ
AtH2SgGiWKrYeuBgVCzs1DFT7sws1KHyLrOdZU0hJQSDfoz/8jwFmXhWoPvQQuWEoo3uvH6L
sHAo53aDF1aAUmGQ/JC72j7zZH16leJFuWj+t2TK/7YEVHtWluA9TOdx2Lz/SHh0/+pAVicD
4N/QUWPuBhzPAgMBAAGjggFmMIIBYjASBgNVHRMBAf8ECDAGAQH/AgEAMB8GA1UdIwQYMBaA
FKDWBz1eJPd7oEQuJFINGaorBJGnMFAGCCsGAQUFBwEBBEQwQjBABggrBgEFBQcwAoY0aHR0
cDovL2NydC5oYXJpY2EuZ3IvSEFSSUNBLUNsaWVudC1Sb290LTIwMjEtUlNBLmNlcjBEBgNV
HSAEPTA7MDkGBFUdIAAwMTAvBggrBgEFBQcCARYjaHR0cDovL3JlcG8uaGFyaWNhLmdyL2Rv
Y3VtZW50cy9DUFMwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMEUGA1UdHwQ+MDww
OqA4oDaGNGh0dHA6Ly9jcmwuaGFyaWNhLmdyL0hBUklDQS1DbGllbnQtUm9vdC0yMDIxLVJT
QS5jcmwwHQYDVR0OBBYEFOuyLzv9rgLMKkQGXSXNHRIiaLBHMA4GA1UdDwEB/wQEAwIBhjAN
BgkqhkiG9w0BAQsFAAOCAgEAO964RfbcPCuTKAq2wXsOZxMaaLxITbSOYkt7RMxPw3CzU2qm
kTQALKbVqC1jUiNQWbkxZpsb8hy9FOHywH1xFmANAypks0Iuh+ovhqP90oFcfhvAfYxV2M0c
Gga9mTKFHP+QET7HW9pZdyWFZAw5fmdW9Ex+IQmJii0w/sozzwhpVn0OQYkkRV+2ydRa68JZ
S2NqAPpdaWoseM2X4u5+Jn+H2UO9paobX+ht91K2Ch8xzfREv4RLqBgpHBmkIDVygXNdXsKf
DHy2hOXxtF6oI1d7ErPGWoBxFc86aUqQlC6pEjb3ug24w+eg1kJj7IufHJ3iRm67Rdw5M1Ol
WMzxu+DwAKqFJhqes0OL/NOJOTuDCb0bIfVfjl8U0Y0QWCkhoCmNPZQQu6QM6Y/XxnALgRB4
drA8kip98wSZQmbqptE8oac2ZzLKCHiJlTdBuREsundnpBXdahMSrJ/mYv2pMZLpYkbrkvyh
orDVeH9t0a5UgPIFqGl8/ZzakJ3RQfr7HvdGur0YWU6KNWvY5BK8qHMRM0b3XtK9xREIGEyc
hAVReodDIhjrR4fWmjpa006r/UrmSk4bpKrVFVzTYsSK3jy4ri1ExVQp6RI6Ou4ZdbfwOYCu
I9wweMjpVBuqNzRKrVU/Pvp57gUzm4u+JJRkdioMOoxZrwsUiYr2KIojwTcwggbvMIIFV6AD
AgECAhBPXyBI3o2lCNUEcHAwcrzzMA0GCSqGSIb3DQEBCwUAMGMxCzAJBgNVBAYTAkdSMTcw
NQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFyY2ggSW5zdGl0dXRpb25zIENB
MRswGQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDEwHhcNMjUwNzAxMTEyODQ0WhcNMjcwNzAx
MTEyODQ0WjCB7TELMAkGA1UEBhMCREUxFjAUBgNVBAgMDU5pZWRlcnNhY2hzZW4xODA2BgNV
BAoML0dvdHRmcmllZCBXaWxoZWxtIExlaWJuaXogVW5pdmVyc2l0YWV0IEhhbm5vdmVyMREw
DwYDVQRhDAhHT1ZERStOSTEPMA0GA1UEBAwGUHJhdXNlMRcwFQYDVQQqDA5MdWthcyBKb2hh
bm5lczEeMBwGA1UEAwwVTHVrYXMgSm9oYW5uZXMgUHJhdXNlMS8wLQYJKoZIhvcNAQkBFiBs
dWthcy5wcmF1c2VAaWt0LnVuaS1oYW5ub3Zlci5kZTCCAiIwDQYJKoZIhvcNAQEBBQADggIP
ADCCAgoCggIBAMCey8Cfa8UVWdHPBu0eKmLN1vBp98X8mwtdWPoWASp77Ce8g8ta0f6y3XAY
6W8+gSrb0etZO/P5vxjus9CSVr9QQQr+AHLx9I2iuurzNoZ4Tq1NYLpfPbsI2xlXnTP7YJcx
kOo2x743dIAP3rkY5LJsccmU+Nw/Cdfmk0Nl1rFYvguj7rjkxVoB0wVnVCgiFeqMWhPVfN1m
iEElmkqZcf30z+lkq6yN7WKVPhw9Me8BBkr6uGJqa1QuQRS8sJswjFkXtIrHHdAuHwhHLm4U
cPYWQlWwY+sAa2CkT9cvMAxa24jHabaJjCTfAQ/cB/9qrBEbw82XWB6CX51gxoKe36AjHiL5
Xdz3eaFvZF/zmUR8OC58M2KObBrZwmBgmbAal0BpfU6EmB0+FaVO54iqb4gKOb9mHGa8Q4o5
qDJwumTaY+1ALd1sUu/XkGbLE6P9PcLXxA4DjjpUD93LALpG70e20POlYVGIo1/P8zA5GDlG
XLQhvdxZMOMS/c9AxtBxNy4QGlJETzHwQkLs9XK5PxyWUXvCYdnHXhHsFnaQi0OB45+3ve88
jI6ayFVUxvirAdwEJLmo0tqzkFL+G4dKmujaoeCnP/mV+Yam9PS1wC/E9tMMrgP+f6htKCzJ
a+R/jl7nuo9gB7b2vdgZa8luFPL9GifWK3QvEwycpZ5DPKZfAgMBAAGjggGSMIIBjjAfBgNV
HSMEGDAWgBTrsi87/a4CzCpEBl0lzR0SImiwRzBKBggrBgEFBQcBAQQ+MDwwOgYIKwYBBQUH
MAKGLmh0dHA6Ly9jcnQuaGFyaWNhLmdyL0hBUklDQS1HRUFOVC1TTUlNRS1SMS5jZXIwKwYD
VR0RBCQwIoEgbHVrYXMucHJhdXNlQGlrdC51bmktaGFubm92ZXIuZGUwYwYDVR0gBFwwWjAJ
BgdngQwBBQMCMAgGBgQAj3oBAzBDBg0rBgEEAYHPEQEBAgQCMDIwMAYIKwYBBQUHAgEWJGh0
dHBzOi8vcmVwby5oYXJpY2EuZ3IvZG9jdW1lbnRzL0NQUzAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC5oYXJpY2EuZ3IvSEFS
SUNBLUdFQU5ULVNNSU1FLVIxLmNybDAdBgNVHQ4EFgQUa+4u0KVjTBoRRNYzCyDqQHvvkGkw
DgYDVR0PAQH/BAQDAgWgMA0GCSqGSIb3DQEBCwUAA4IBgQCNMzZAFmerRlElJ/YZ1KmKt3FB
QH37XjUYYDlmx8a+zw+THQI8uxBUBVFulpxD6eCZ9VT4hEznAV8CeAyg+FZ3m8gHUoMF7Ge9
tAej/iH1nHLXRt8SEnwwfpICAVPoZT32hf9gmu1sxlaxKPb+dO7e8eoQoFRTlWOIoYtf5+dN
1PXsLEcyQEx9RnJZeDjyZmN5HtcAxMzCzAm7otP+YLXCVi8OiQM2ytcCaBKKrtc1tYlrJpl+
8ot2YfbvAAF0TPc0Mj4xOZ1a4CtqAIOWmuKynK5jO4tbMEbN5S/+oFihm5as0MeeMVECLcT6
wHinSGM2ALMC2Vxw3nzL/7v1H+GxVlGM91bLRCCFxYPKr/lnVu6GqLHNZpWUVjXTw4pfANY4
HPBK7tDWqfrNVPKJlk0YFUK0M6i/5AFwgcHK1bv/4hwMi9VdXIXsB/OPeHa9D5t+/WkBqk3F
ZM/GjOWPhKUjVHdgByoq5M6qbxBNQLQWZg+jUa2KPshqEfwudiTA/IgxggXFMIIFwQIBATB3
MGMxCzAJBgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFy
Y2ggSW5zdGl0dXRpb25zIENBMRswGQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDECEE9fIEje
jaUI1QRwcDByvPMwDQYJYIZIAWUDBAIDBQCgggMfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDkwODExMjIyMVowTwYJKoZIhvcNAQkEMUIEQO4Mh4TC
6Mb8NqXpDh2CAIqP9naj2o5hsaRNC0mxuB8y6Q7qHqQMVfBvj4B42KzveyC/1dP4hw3BxM6Y
Wm419p8wgYYGCSsGAQQBgjcQBDF5MHcwYzELMAkGA1UEBhMCR1IxNzA1BgNVBAoMLkhlbGxl
bmljIEFjYWRlbWljIGFuZCBSZXNlYXJjaCBJbnN0aXR1dGlvbnMgQ0ExGzAZBgNVBAMMEkdF
QU5UIFMvTUlNRSBSU0EgMQIQT18gSN6NpQjVBHBwMHK88zCBiAYLKoZIhvcNAQkQAgsxeaB3
MGMxCzAJBgNVBAYTAkdSMTcwNQYDVQQKDC5IZWxsZW5pYyBBY2FkZW1pYyBhbmQgUmVzZWFy
Y2ggSW5zdGl0dXRpb25zIENBMRswGQYDVQQDDBJHRUFOVCBTL01JTUUgUlNBIDECEE9fIEje
jaUI1QRwcDByvPMwggF+BgkqhkiG9w0BCQ8xggFvMIIBazALBglghkgBZQMEAS4wCwYJYIZI
AWUDBAEaMAsGCWCGSAFlAwQBBjALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA0GCCqGSIb3DQMCAgEFMA0GCCqGSIb3DQMCAgEFMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEFMAcGBSsOAwIaMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIDMAsG
CWCGSAFlAwQCBDALBglghkgBZQMEAgcwCwYJYIZIAWUDBAIIMAsGCWCGSAFlAwQCCTALBglg
hkgBZQMEAgowCwYJKoZIhvcNAQEBMAsGCSuBBRCGSD8AAjAIBgYrgQQBCwAwCAYGK4EEAQsB
MAgGBiuBBAELAjAIBgYrgQQBCwMwCwYJK4EFEIZIPwADMAgGBiuBBAEOADAIBgYrgQQBDgEw
CAYGK4EEAQ4CMAgGBiuBBAEOAzANBgkqhkiG9w0BAQEFAASCAgByYUrqHhiUbhJX67E7yxRl
Gfs1SSIFZGaoN+s59ESFx3t2K2qHreNSnvmy5gwxZKEMaSeYEA3aLzG2B+liqIzb2cx4Gm2X
qGhx3aBPa3tmYqyKhsQCiwyQKaGqH4fbaYP3hhIPz0Osq4e066Wj5m+QIOeDmVTdA15O6/qb
2o3XW3onepGyquI+9z3Fve/zAVrZPdOpuR4mWYuFiBgnsCbLLHKmt9R8E1P6G0gvFrgfV2aH
HcJ/hvNd3LjzOYbfBgCJIbPHZ69v7wHjfdE8XQA+f6HZipBgpHf7B1BbMhy6o3UhLSyAc6UO
uQUvRZoEl1S4DxnbivaxjSNelagM1pjTPOHKimmK7lvnvnlhIHwokoJY6XSToB+aRouAsHGT
DtoMDYmW/YzVZUVNCdgqGSuf5f+1oIjhz3N5M3LmEePON7yxZM+izI8twW4d5fGwVhvbxTZm
EihpY0DgsJM3vX577oXFoABgCmXDSKGb65jjflnsotm7z5B+3RgOVVPHRdRBMXF/xWNJ6Bdp
lfGOTZymOq8flkgmAEi2gPAprpMxhNxFqvKC+Sx63mBGkCh4QmbE+DuQlCP/Nflvj4uuTuu4
1ILgIqbe6m+a4/GCsEGKGL0+9OwPXhRe7WdD7oEDOp4ZOjyBC3ayn5T01AOE6vSiZQsIkpYw
K2B1L8K1bGqhLwAAAAAAAA==
--------------ms030801050306050308000503--
