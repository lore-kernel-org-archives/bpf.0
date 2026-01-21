Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5740FDAC
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988175; cv=none; b=B4fY19Su2pYMpiXKr/wljDQaJAJrAVHJlCMcCKSstdyNnjEHzFBMn1T/V7I//ilyTyp6qnMTPkTpdHQciPrDn4qV4rtDF1ClODYsUvU7Q2iE4at82LHDpJ2LwPf878iZ8efebwgJj4sEIpCIbg0EkBFF9ZUNjtoYYa0KUqIHJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988175; c=relaxed/simple;
	bh=VePwZWQjyG/lkPhMD1doEoS8+SnaSICnkySCxMdC+eY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FrA8+EYsC5MbbnzSqD5heo0ZeUMFZB7vzP26o6DNGeNwx9v43382shvlEPDqAkTQmqkHKEC8yS8Sa9dTIyQIxi37O8LtSQhWqxi1ZZn5vq2sLmDn1I3UmDml/QsBMM+InSyGKPDa4GJMall5OyHLPZf0dT7RugVpT0XzXAJFPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GXKrljIB; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GXKrljIB"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b87f3c684a1so397122266b.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988171; x=1769592971; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiYtaE993SXtVFhxzqlZeFKLdnPF4/n1BfwiEy+DPc=;
        b=GXKrljIBTT1sJWJysykALAO2h+4+wWWolgRcQRxh1nKk9IYjZPeB+Yb+7ODE+US+Tx
         M1d7uBiv6jg56zM6FrtQQf/pqGY+cywC9P1vMIuGtEBAh3PLgfHPH2KcrzFtIscflHHf
         fDXNeBSFSrYKZRLKBkJc2ROKS8YdJiwGdDjTSIO4F0FpOAkjSQNj9nCSMlWdHLR/NRTK
         M7lAnUDeWs1UAKsVgUy7osW/vVwWRsSlQzVq2H82NukpK3m9do82M1ViQrCI7DKk76ri
         FstzaccecQC/7JSvN1hvTTpDO/49QtMTJiGEN7pyVarTgJqObl75ziNCI24W19vyCjzF
         ADHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988171; x=1769592971;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFiYtaE993SXtVFhxzqlZeFKLdnPF4/n1BfwiEy+DPc=;
        b=vlTzX5sG9UAggHBzG8n3iD+IV0X1HM6tQa5XP9SAlNuGafnprdTRuBZEZKhbKjn64X
         eCHQRpPwfPqZjBzvJONVwqqtV+tQpOh2lkednLXdUXYPMCqKqxd+UxQuzafQeUQSD+2o
         as2Cnekei2dg35IKYpE5mXPnDBibzXZyFy8SaB3k9eqIRHTdBjut4Z6D3aKB69eHasqD
         +hKpVbwymBfp/WFZu6JMVDScUxx+sIx4ShDa1WYe/4uCKX2C9gMqDlnjX0mVGHGadPv+
         iirn7FFpJg9HjHY84lfS2iTvpLlh/xT3CD7NK5nDM6f4Td+xhiFbWKJwFsnF0szGTHVe
         6Wyw==
X-Gm-Message-State: AOJu0YyJxDxrnq2wCBt27VwiEMdTEHM9eIlFinGO/RTmXhYCed0ceXvu
	ahuuSbPjgtqn1WkXz1srBRbJcCJobldOYWwdek05nHNvuwItiXHaJzoX7pOrg52v4zA=
X-Gm-Gg: AZuq6aLZVi+C0/2/WdDqvCkcIb6cas7oaAYEXLxtPePErpTPDG1LpU+NOxYQBjMXhit
	PhIkYZzMbZs5ASSItdeoP8YTSrKnv+qiOGw5mZGqTj7+TCtWxgDk394VMc14nvuoGjRXNoGZmvZ
	TZGT0Bdjvvvkm8RHIuOf9sfBdWIA2NBPxK0Gchs4loWFg2EHN4vUQpj1H0w3FJ/IHauZooiHo7/
	oLk4jkRt0i3R647l1cUu31gpCHAsa9dWFG1sjsLsb6/aQGbZDJanCWVvCjkjvTr+KBtb3JZ87kM
	TFJWXmF3XBxq+3/PMqnAlhqowKEYyHRtpq71+rYOr0jfunmv7GsB0fbJ4CMkio45TFpD5jUUIgi
	59IeVGoccO5L6fdESo5VeSxh5wx8IJ9KAHhy9+GWHIeAMwTbPIKAc68rBriw07Us8vJ1o7fv8fv
	Nf4A==
X-Received: by 2002:a17:907:a08:b0:b87:6b9c:6386 with SMTP id a640c23a62f3a-b88003930cfmr401546966b.56.1768988171029;
        Wed, 21 Jan 2026 01:36:11 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e72asm1561568766b.11.2026.01.21.01.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <87a4y8uy67.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Tue, 20 Jan 2026 16:00:16 +0100")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-3-jiayuan.chen@linux.dev>
	<87a4y8uy67.fsf@cloudflare.com>
Date: Wed, 21 Jan 2026 10:36:09 +0100
Message-ID: <871pjjux2u.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 20, 2026 at 04:00 PM +01, Jakub Sitnicki wrote:
> On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:

[...]

>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
>> index 0735d820e413..91233e37cd97 100644
>> --- a/net/ipv4/udp_bpf.c
>> +++ b/net/ipv4/udp_bpf.c
>> @@ -5,6 +5,7 @@
>>  #include <net/sock.h>
>>  #include <net/udp.h>
>>  #include <net/inet_common.h>
>> +#include <asm/ioctls.h>
>>  
>>  #include "udp_impl.h"
>>  
>> @@ -111,12 +112,26 @@ enum {
>>  static DEFINE_SPINLOCK(udpv6_prot_lock);
>>  static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
>>  
>> +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>> +{
>> +	if (cmd != SIOCINQ)
>> +		return udp_ioctl(sk, cmd, karg);
>> +
>> +	/* Since we don't hold a lock, sk_receive_queue may contain data.
>> +	 * BPF might only be processing this data at the moment. We only
>> +	 * care about the data in the ingress_msg here.
>> +	 */
>
> I think we should strive for a design where FIONREAD does not go down
> after you add your socket to sockmap, if there was no recvmsg call in
> between. To show what I mean, I added this test that's currently failing
> for udp:
>
> ---8<---
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1f1289f5a8c2..123c96fcaef0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1229,6 +1229,66 @@ static void test_sockmap_copied_seq(bool strp)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
>  
> +/* Test FIONREAD when data exists in sk_receive_queue before sockmap insertion */
> +static void test_sockmap_fionread_pre_insert(int sotype)
> +{
> +	int map, err, sent, recvd, zero = 0, avail = 0;
> +	struct test_sockmap_pass_prog *skel = NULL;
> +	int c = -1, p = -1;
> +	char buf[10] = "0123456789", rcv[11];
> +	struct bpf_program *prog;
> +
> +	skel = test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	prog = skel->progs.prog_skb_verdict;
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> +		goto end;
> +
> +	err = create_pair(AF_INET, sotype, &c, &p);
> +	if (!ASSERT_OK(err, "create_pair"))
> +		goto end;
> +
> +	/* Step 1: Send data BEFORE sockmap insertion - lands in sk_receive_queue */
> +	sent = xsend(p, buf, sizeof(buf), 0);
> +	if (!ASSERT_EQ(sent, sizeof(buf), "xsend pre-insert"))
> +		goto end;
> +
> +	/* Step 2: Verify FIONREAD reports data in sk_receive_queue */
> +	err = poll_read(c, IO_TIMEOUT_SEC);
> +	if (!ASSERT_OK(err, "poll_read pre-insert"))
> +		goto end;
> +	err = ioctl(c, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) pre-insert error");
> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) pre-insert");
> +
> +	/* Step 3: Insert socket into sockmap */
> +	err = bpf_map_update_elem(map, &zero, &c, BPF_ANY);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
> +		goto end;
> +
> +	/* Step 4: FIONREAD should still report the data in sk_receive_queue */
> +	err = ioctl(c, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) post-insert error");
> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) post-insert");
> +
> +	/* Verify we can still read the data */
> +	recvd = recv_timeout(c, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
> +	ASSERT_EQ(recvd, sizeof(buf), "recv post-insert");
> +	ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch");
> +
> +end:
> +	if (c >= 0)
> +		close(c);
> +	if (p >= 0)
> +		close(p);
> +	test_sockmap_pass_prog__destroy(skel);
> +}
> +
>  /* it is used to send data to via native stack and BPF redirecting */
>  static void test_sockmap_multi_channels(int sotype)
>  {
> @@ -1373,4 +1433,8 @@ void test_sockmap_basic(void)
>  		test_sockmap_multi_channels(SOCK_STREAM);
>  	if (test__start_subtest("sockmap udp multi channels"))
>  		test_sockmap_multi_channels(SOCK_DGRAM);
> +	if (test__start_subtest("sockmap tcp fionread pre-insert"))
> +		test_sockmap_fionread_pre_insert(SOCK_STREAM);
> +	if (test__start_subtest("sockmap udp fionread pre-insert"))
> +		test_sockmap_fionread_pre_insert(SOCK_DGRAM);
>  }
> --->8---
>
>
>> +	*karg = sk_msg_first_len(sk);
>> +	return 0;
>> +}
>> +

I've been thinking about this some more and came to the conclusion that
this udp_bpf_ioctl implementation is actually what we want, while
tcp_bpf_ioctl *should not* be checking if the sk_receive_queue is
non-empty.

Why? Because the verdict prog might redirect or drop the skbs from
sk_receive_queue once it actually runs. The messages might never appear
on the msg_ingress queue.

What I think we should be doing, in the end, is kicking the
sk_receive_queue processing on bpf_map_update_elem, if there's data
ready.

The API semantics I'm proposing is:

1. ioctl(FIONREAD)              -> reports N bytes
2. bpf_map_update_elem(sk)      -> socket inserted into sockmap
3. poll() for POLLIN            -> wait for socket to be ready to read
5. ioctl(FIONREAD)              -> report N bytes if verdict prog didn't
                                   redirect or drop it

We don't have to add the the queue kick on map update in this series.

If you decide to leave it for later, can I ask that you open an issue at
our GH project [1]?

I don't want it to fall through the cracks. And I sometimes have people
asking what they could help with in sockmap.

Thanks,
-jkbs

[1] https://github.com/sockmap-project/sockmap-project/issues


