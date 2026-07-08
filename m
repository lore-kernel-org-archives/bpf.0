Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838F42B311
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527597; cv=none; b=o+gF+spwjZbRZd9kaNErKV8vTP4hR91a5LxAN1DzUakYT33sbbzdauaTQv+hqA9Q0IAUF6P4kDOqtB6dG3zp5qdqxPUys9qukQHy3B5+pRN7V8ZXIVsgkEnANjvj8gOIGPSEmKYWDyN8763MD/dQJ4l7Ub03cBQsp9ALAmCROcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527597; c=relaxed/simple;
	bh=LqRAHZpn9XsmnomtiA/+PnRH4DsQWzTchYzEcXUBzzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JfaxHaJ/zfNLW6vGUcYEEnBaUyAeZYXrEUQs/Xe8sOiIjcOd7e5MirAVw8muHLJ7iN5T3p2/m2trj070I7HX8V2ogKia3psRip65dP1rrnFbcdPklKK9F3mu6g9Fgi7XgqbDQOBgCdwum7i1VEuQBvFvgRr4HkhvQslA/gCN43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=X7RuaNBc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="X7RuaNBc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c7c61b5292so16990405ad.0
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783527595; x=1784132395; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KoeQIzrdmjIACDxHWQZkS7jhZWHaXngGQAZTPpEL6vk=;
        b=X7RuaNBctzYyEIibVicUKWtIPdBaXKUeTXIHLe58U7zhA/wCRzfaU1MrTjT8fC4RJy
         TcchrOPiH7wN8BRkW2WB+iH6sc2g3pnvHoft7L8C0Fx/9pz5i6YyNo1j6j7arUzXks1d
         y2xkQBdyzNaLQ5I810+/Gv5BeEHnR0AZ+rZ1eArJwGd80Rnv1ihyICtyr+GxZSb9hb28
         KevviloO+GYQtdnv6Xa6OUvVVK5sO/OXsgzzgZaj8hh+MBAJrg1As7LcMB2XkkyHpD29
         fGH3MoXRyIc2krjsbtBlivBLkgLNokzKt1sGRgdPDkr51jDQ6RCL44Bmo5Xk1HGMekvf
         27DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783527595; x=1784132395;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoeQIzrdmjIACDxHWQZkS7jhZWHaXngGQAZTPpEL6vk=;
        b=UkDWsE67wORLQkn63ObOdcnuIKf5BrRUJi1GnS8rdwDn2yMNEpJxpaneQYITRFnVdS
         aowNYmCeYh9X0IXwPQKgrRIKVapExQAgugOJ2zaO+wXlw3Rs7+W/x3SWXOZpxnTHfCLx
         ZP/8guW0MgojtNoFFSnt7b60Sgr4OFhYcObJnO7rH6RGD1LZQQsRQbM2Q9hhwoPAyUEp
         tTQcT4xg20PkkX56UdJ/5YcE04u+HyWK/ZTby/pnKGAGD49r3JJoG1olSp0vwCyaUaiW
         aJpATwaAFl9LNM7uG5i+5GJreRvXqJeNJ4ZaN5Zd44iyZQYHxL131Y9DyvJcdgmodxI2
         xnuw==
X-Forwarded-Encrypted: i=1; AHgh+RolqsPleKFSK6U0ff2M28Gt4OY6wxnOMZnHi6hnEU/x28zpoHiols3YvCz1MXklljlylJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3R4xgN6YMf/glOkZStomP44ParHqRWNGPn0mwlEHde2nk6z36
	+inooM3+zT1rvAK3iEOqq/BUN+PSdw8pbWknvKXTVx+fYOcNSNjDHVyH2yFIgVv09e4=
X-Gm-Gg: AfdE7cn8RhaWJiGz3wHH3nqEASPKhEfBv0IjthyThRhJ9pML6dsxX0PcmXkbnKdUFqo
	oYRHiEtFeEr0JN3Caw1JQ1z57kx9Wtb/7yycXjvs7VSb0HHLTWnWx3R3pI8ByoJx1wWtlzwB9tY
	phq+NbB7Y5Zf1/PLe/mqe7jsZw442xx/Q4Rtel888Uj4PInB8jGwmc+aVCBM3M398pkUqS41PGi
	v6hJZtOtJNb+ZJTBOnP1SbItDlL3pWwIoA4VSQX4Z+Pqv7txrgNGTUwfFEcAjk3s2qqTtlNo/zf
	JAQv5Fp66bsuH3PWLbjXFfzLNeH93QlIJEQgCV0FnB96mgGTxgafnrckM7m55rp3VRMP8ekO12p
	dme9XDHvMIMBsKbEQrpOdn6v0u5jyBB+6X1KQQzgvCESrK4r2TaUOEvWT0gkj06LuiYleYwuk5U
	r9vmceG0NnwnZDl8x4JF3KmPG8zxnsP2HxFD3hwPRxuw==
X-Received: by 2002:a17:902:e5c5:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2ccea2cbd6amr32640175ad.14.1783527595214;
        Wed, 08 Jul 2026 09:19:55 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d2efsm30247775ad.64.2026.07.08.09.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 09:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 12:19:54 -0400
Message-Id: <DJTBRLLCR138.YFMNJ4MITDR7@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
 <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>
 <DJSWX1VY6XXI.1XRGI8HMHT6JT@gmail.com>
In-Reply-To: <DJSWX1VY6XXI.1XRGI8HMHT6JT@gmail.com>

On Wed Jul 8, 2026 at 12:41 AM EDT, Kumar Kartikeya Dwivedi wrote:
> On Tue Jul 7, 2026 at 7:19 PM CEST, Emil Tsalapatis wrote:
>> On Tue Jul 7, 2026 at 12:15 PM EDT, Mattia Meleleo via B4 Relay wrote:
>>> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>>>
>>> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
>>> counts bytes in ingress_msg. Without a stream/skb verdict program
>>> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
>>> returns 0 even though read() returns data.
>>>
>>> Add tcp_inq() to the reported value when the psock has no verdict
>>> program. The two queues are disjoint, so bytes redirected into
>>> ingress_msg from other sockets stay correctly accounted through
>>> msg_tot_len.
>>>
>>> Add a selftest covering FIONREAD without a verdict program.
>>>
>>> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
>>> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>
>> I don't think the Sashiko READ_ONCE() recommendation is that important,
>> we're just checking for the pointers' existence and I don't see how the
>> reads can be moved/optimized out/merged in a way that breaks this code.
>>
>
> It would be necessary if the xchg() can happen even when the lock is held=
, at
> the very least, to suppress potential KCSAN warnings, I think. Even for t=
he
> theoretical load tearing that causes false positive, it would be benign d=
ue to
> wrong accounting.
>

Fair enough, nothing wrong with adding the READ_ONCE since the set already
needed respinning.

>>> ---
>>>  net/ipv4/tcp_bpf.c                                 | 16 ++++++++-
>>>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++=
++++++++
>>>  2 files changed, 54 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>>> index cc0bd73f3..a001b1fff 100644
>>> --- a/net/ipv4/tcp_bpf.c
>>> +++ b/net/ipv4/tcp_bpf.c
>>> @@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>>>
>>>  static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>>>  {
>>> +	struct sk_psock *psock;
>>>  	bool slow;
>>>
>>>  	if (cmd !=3D SIOCINQ)
>>> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd,=
 int *karg)
>>>  		return -EINVAL;
>>>
>>>  	slow =3D lock_sock_fast(sk);
>>> -	*karg =3D sk_psock_msg_inq(sk);
>>> +	psock =3D sk_psock_get(sk);
>>> +	if (unlikely(!psock)) {
>>> +		unlock_sock_fast(sk, slow);
>>> +		return tcp_ioctl(sk, cmd, karg);
>>> +	}
>>> +	*karg =3D sk_psock_get_msg_len_nolock(psock);
>>> +	/* Without a verdict program, ingress data is never diverted to
>>> +	 * ingress_msg: it stays in sk_receive_queue and is read through
>>> +	 * the fallback to tcp_recvmsg(), so account for it like
>>> +	 * tcp_ioctl() does.
>>> +	 */
>>> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)
>>> +		*karg +=3D tcp_inq(sk);
>>> +	sk_psock_put(sk, psock);
>>>  	unlock_sock_fast(sk, slow);
>>>
>>>  	return 0;
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/t=
ools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>>> index cb3229711..f0f368201 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>>> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int soty=
pe)
>>>  	test_sockmap_pass_prog__destroy(skel);
>>>  }
>>>
>>> +/* A socket in a sockmap without a verdict program keeps its ingress d=
ata
>>> + * in sk_receive_queue: FIONREAD must account for it.
>>> + */
>>> +static void test_sockmap_no_verdict_fionread(void)
>>> +{
>>> +	int err, map, zero =3D 0, sent, avail;
>>> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
>>> +	struct test_sockmap_pass_prog *skel;
>>> +	char buf[256] =3D "0123456789";
>>> +
>>> +	skel =3D test_sockmap_pass_prog__open_and_load();
>>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>>> +		return;
>>> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
>>> +
>>> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1)=
;
>>> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
>>> +		goto out;
>>> +
>>> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
>>> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
>>> +		goto out_close;
>>> +
>>> +	sent =3D xsend(p1, &buf, sizeof(buf), 0);
>>> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
>>> +	avail =3D wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
>>> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
>>> +
>>> +out_close:
>>> +	close(c0);
>>> +	close(p0);
>>> +	close(c1);
>>> +	close(p1);
>>> +out:
>>> +	test_sockmap_pass_prog__destroy(skel);
>>> +}
>>> +
>>>  void test_sockmap_basic(void)
>>>  {
>>>  	if (test__start_subtest("sockmap create_update_free"))
>>> @@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
>>>  		test_sockmap_skb_verdict_shutdown();
>>>  	if (test__start_subtest("sockmap skb_verdict fionread"))
>>>  		test_sockmap_skb_verdict_fionread(true);
>>> +	if (test__start_subtest("sockmap no_verdict fionread"))
>>> +		test_sockmap_no_verdict_fionread();
>>>  	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>>>  		test_sockmap_skb_verdict_fionread(false);
>>>  	if (test__start_subtest("sockmap skb_verdict change tail"))
>>>
>>> ---
>>> base-commit: d2c9a99135da931377240942d44f3dea104cedb8
>>> change-id: 20260707-fionread-no-verdict-a4f8697ac9f9
>>>
>>> Best regards,
>>> --
>>> Mattia Meleleo <mattia.meleleo@coralogix.com>

