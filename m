Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BD372EFB
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485708; cv=none; b=QSj4F6s1zCJN0JYMPrtpnKTgNfh6IkcmZnjhVDtnkvrq87poq2CptDVjSnRAK+jm9YPL5obZ9kNRPry9NTamunDX9o/7egCYaRpEe1v1Oold6PVW7uPmZtcS6J02YKcKFlL+Y4l3uSEa8UtY0Kl9WBmQHK0R6Gue4JW9vC7e/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485708; c=relaxed/simple;
	bh=dFWF4mbM7fec3CKjtLHwa3ijZn4lRngduD1c5Ag3pIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cexqP1sbvBc9/4RXaRLVm/G8sB0Ob5mZClC/PP58AFOgg7eOJaC1HOmqwdd+tExzgGjRS1VA772sOc69OjSZq23C6ixuS3xeOy78ppxWsoxGCJaS9d1GXSuePua2nuOKGzGmkQ6Tysbgh34wzJ9Wk5dgcdy7c4HkdbfkCMSFYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8jv2xkK; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8jv2xkK"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so82832f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 21:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783485705; x=1784090505; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ieK6Nyjgx80dc31yGSF9T1zWne7nTxPTT4G9KM0zXSM=;
        b=j8jv2xkKJRLwwjJuh8evMPjITmI838I7rrdvfHg6m6fVSv1iBozM4gSGTfKwZH1+Qh
         Dvs2buYxhYkYxXrZsKfB2SCOalp2M0GEBumbErINPW0Xy9AX6W3MN3Mno2v75sQdzGfD
         by/b/Kuu6Hf30aRmpCAZNVyk/ufcxh5g2gt24zCipwx3OahJVoyGg+/JES714R7z4K/b
         cE3jtHgPmi3jV2hFrzBH160K8cxrIui/Prjy6cylay9HiY1efg2qgKd5/sRcjTIeRUI/
         CK8EK0pQurvphQ0GxEMG5BQ3nZcKLpAvcHQiSYmIWum6kYlmkL8GXxyeJ+hjoHZEWkmH
         ajzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783485705; x=1784090505;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieK6Nyjgx80dc31yGSF9T1zWne7nTxPTT4G9KM0zXSM=;
        b=FrFjbChY8cc3EqCLk2kGI69VUfNiqAYPFoMm90DtJaXanvVDy/BkQLOKiKyg9VJtZR
         NjhesJWGF8gInRzQxkIp/ZGQwSOdO3/D57Chi50PO8K11j0XJowiRQFZG8e2TpQsFnRT
         S3joe1pLnvLcEY69Fa+TCChaAQsYTMQZvDbT6b2YFGeFXz93eVEWqWHGw9v2A+axJ44z
         uUypdQknJ+wPbFt/8ygsI964jI4zJGTCpSeI9YOp5fwILfjFvzEIXlnt+4xxIKrL8V7g
         1H6gpJLjdz2GvV/pHyJh3ODR6ecJGxLuX9DP3CLWZeAQaWQ0hQXJy1gKajq43d0I4r2F
         gv/A==
X-Forwarded-Encrypted: i=1; AHgh+RrLOBPKdlu88te+DQVSV3N2nkvn0vfSADrwAki0VyDRLfH3ypATz6Oef0xirw57M6GHxsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGoWQ5FclmepeNwEDjJClWGDd+X1Hb1DyLYvYqxTgmjgMzMBu
	UyMhqofPaBxzuGrEN4tK/9yRnwJwTwwwc/v6Nri6lPYA8o760K9RNrJX
X-Gm-Gg: AfdE7cmJQAYShp7mdTbRPX70j6uOXTGJC4/bAJ6CbyYrJGJn0PevNWGtMiqoJU9Hqot
	FgIBT2HScCDxNGCM0d/56kcc3jkoAp20NZ0dkrCx7cZ9Yy8Sq/Y5c2VAMw+Tq014dFBdKzQ3xnQ
	dfWkCO5JLB7hgS15pPAUls9pqLMUhHAfdnnc8VDgfmEEY01XQOQhUeCoqIO4TYXZxoehOkWTatm
	pjwWMZc86milSu+zcwX9GEwGx/4VS9Xp1Eg5uLMYU8KpkY2qPayJQJM1mOF5fa2E/LqLOiLzvtF
	/pNT5I+EeSPE7sz7npmjdKoEH1OyfD8k1BaQ135uZKMlhLT2HYC/SYmygZppupI8JVDNE5OwVWT
	fnec6gKb58+BPKKtat+SVeCwZDT5iqEBW6mVXiK98W6Y+0UAUOuvVJh6lMUYHwo5I89DpxJB6zZ
	E9An6mt3GbW6mGiAS7AlE1MOwIoY8iiwL/SGbskxBmENa/Y0AyQMYiEo1Pb6vpoLCeMiyfvj9rz
	c0+aahnushp8tS+cW/CoVcjY8zeKWE+Lmg2YXLppP6MQmCKGeA31rA=
X-Received: by 2002:a05:6000:2484:b0:478:1564:f756 with SMTP id ffacd0b85a97d-47df0735a3dmr536168f8f.27.1783485705373;
        Tue, 07 Jul 2026 21:41:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm39108953f8f.27.2026.07.07.21.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 06:41:44 +0200
Message-Id: <DJSWX1VY6XXI.1XRGI8HMHT6JT@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>,
 <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
 <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>
In-Reply-To: <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>

On Tue Jul 7, 2026 at 7:19 PM CEST, Emil Tsalapatis wrote:
> On Tue Jul 7, 2026 at 12:15 PM EDT, Mattia Meleleo via B4 Relay wrote:
>> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>>
>> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
>> counts bytes in ingress_msg. Without a stream/skb verdict program
>> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
>> returns 0 even though read() returns data.
>>
>> Add tcp_inq() to the reported value when the psock has no verdict
>> program. The two queues are disjoint, so bytes redirected into
>> ingress_msg from other sockets stay correctly accounted through
>> msg_tot_len.
>>
>> Add a selftest covering FIONREAD without a verdict program.
>>
>> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
>> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> I don't think the Sashiko READ_ONCE() recommendation is that important,
> we're just checking for the pointers' existence and I don't see how the
> reads can be moved/optimized out/merged in a way that breaks this code.
>

It would be necessary if the xchg() can happen even when the lock is held, =
at
the very least, to suppress potential KCSAN warnings, I think. Even for the
theoretical load tearing that causes false positive, it would be benign due=
 to
wrong accounting.

>> ---
>>  net/ipv4/tcp_bpf.c                                 | 16 ++++++++-
>>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 +++++++++++++++=
+++++++
>>  2 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index cc0bd73f3..a001b1fff 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>>
>>  static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>>  {
>> +	struct sk_psock *psock;
>>  	bool slow;
>>
>>  	if (cmd !=3D SIOCINQ)
>> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, =
int *karg)
>>  		return -EINVAL;
>>
>>  	slow =3D lock_sock_fast(sk);
>> -	*karg =3D sk_psock_msg_inq(sk);
>> +	psock =3D sk_psock_get(sk);
>> +	if (unlikely(!psock)) {
>> +		unlock_sock_fast(sk, slow);
>> +		return tcp_ioctl(sk, cmd, karg);
>> +	}
>> +	*karg =3D sk_psock_get_msg_len_nolock(psock);
>> +	/* Without a verdict program, ingress data is never diverted to
>> +	 * ingress_msg: it stays in sk_receive_queue and is read through
>> +	 * the fallback to tcp_recvmsg(), so account for it like
>> +	 * tcp_ioctl() does.
>> +	 */
>> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)
>> +		*karg +=3D tcp_inq(sk);
>> +	sk_psock_put(sk, psock);
>>  	unlock_sock_fast(sk, slow);
>>
>>  	return 0;
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> index cb3229711..f0f368201 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotyp=
e)
>>  	test_sockmap_pass_prog__destroy(skel);
>>  }
>>
>> +/* A socket in a sockmap without a verdict program keeps its ingress da=
ta
>> + * in sk_receive_queue: FIONREAD must account for it.
>> + */
>> +static void test_sockmap_no_verdict_fionread(void)
>> +{
>> +	int err, map, zero =3D 0, sent, avail;
>> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
>> +	struct test_sockmap_pass_prog *skel;
>> +	char buf[256] =3D "0123456789";
>> +
>> +	skel =3D test_sockmap_pass_prog__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +		return;
>> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
>> +
>> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
>> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
>> +		goto out;
>> +
>> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
>> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
>> +		goto out_close;
>> +
>> +	sent =3D xsend(p1, &buf, sizeof(buf), 0);
>> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
>> +	avail =3D wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
>> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
>> +
>> +out_close:
>> +	close(c0);
>> +	close(p0);
>> +	close(c1);
>> +	close(p1);
>> +out:
>> +	test_sockmap_pass_prog__destroy(skel);
>> +}
>> +
>>  void test_sockmap_basic(void)
>>  {
>>  	if (test__start_subtest("sockmap create_update_free"))
>> @@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
>>  		test_sockmap_skb_verdict_shutdown();
>>  	if (test__start_subtest("sockmap skb_verdict fionread"))
>>  		test_sockmap_skb_verdict_fionread(true);
>> +	if (test__start_subtest("sockmap no_verdict fionread"))
>> +		test_sockmap_no_verdict_fionread();
>>  	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>>  		test_sockmap_skb_verdict_fionread(false);
>>  	if (test__start_subtest("sockmap skb_verdict change tail"))
>>
>> ---
>> base-commit: d2c9a99135da931377240942d44f3dea104cedb8
>> change-id: 20260707-fionread-no-verdict-a4f8697ac9f9
>>
>> Best regards,
>> --
>> Mattia Meleleo <mattia.meleleo@coralogix.com>

