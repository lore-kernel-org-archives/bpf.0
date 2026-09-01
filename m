Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203432A3E5
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267637; cv=none; b=p0H1wTd6LRKZbwyjD0FZJSzmIGb4L+wx4pBNAB0XzinQOYjarccd400yMTcfRBtbJkDe+MTsNZXY09HpSpBU+gqb1OQIejRR/LUHGZl2BZLU06B07bSKfPF9MPfoG39/LaYpPTWzUknX16YHSPcje2xeXCIawAQqrG36zJVHx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267637; c=relaxed/simple;
	bh=xdjfVhalLoy5JT5Aiv2C+7xPblN/B0sRyEn65UjqdNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUR99GwEOnPWjnrg+WkrZRE3aKT01Jkqsc2f+jdyYmM4st0BFaiUDxFSec/6ulsCj3BsM50R1OHuiLmAqYyz+O1cVqpzy89mR9VdMYdP6MTBihaIi4a4EcapNDKFm6tpTsMMAMruoI32CPFGL6zNxdRqVV+LwiVENThnxSW9Cfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rL3DvukH; arc=none smtp.client-ip=95.215.58.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rL3DvukH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xdjfVhalLoy5JT5Aiv2C+7xPblN/B0sRyEn65UjqdNU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788267632; v=1; x=1788872432;
 b=rL3DvukHibtugbNqanZdIDaGLvo4qn27hnrtwUNwnvLFIF89f4lyxPyVgMUOOG1v0v6xTfnL
 JB/w9VYiGt2sq7fy9owAdoLVS+IsnVV1DfQTUEwJIJB+VnPpvBZgSjlU0o5yBRxKmTH/r/HT3wa
 QowayiHcUt8uxmUHXaMqaC9c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ab401a24851f2d6f;
	Tue, 01 Sep 2026 13:00:32 +0000
X-Mizu-Trace-ID: ab401a24851f2d6f
X-Migadu-Flow: FLOW_OUT
Message-ID: <8d1e416d-202f-4fcb-85f6-aa380645216f@linux.dev>
Date: Tue, 1 Sep 2026 21:00:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, sockmap: Fix self-redirect copied_seq
 double-counting
To: Jakub Sitnicki <jakub@cloudflare.com>, Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Geliang Tang
 <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn>
 <87wlt52od6.fsf@cloudflare.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <87wlt52od6.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


on 9/1/26 7:38 PM, Jakub Sitnicki wrote:
> On Sat, Aug 29, 2026 at 10:00 AM +08, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> When a BPF stream_verdict program redirects an skb back to the same
>> socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
>> calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
>> skb is then delivered to the socket's psock ingress queue and later
>> read by tcp_bpf_recvmsg_parser(), which also advances copied_seq via

Hi Geliang,

tcp_eat_skb() will test 'skb_bpf_strparser(skb)' then skip the 
calculation of copied_seq.



>> the copied_from_self accounting path. This double-counting causes
>> copied_seq to advance by 2x the actual data length, triggering:
>>
>>    TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
>> 			   rcvnxt BF2E806, fl 0
>>    WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x72b/0x2640
>>    Call Trace:
>>     tcp_recvmsg+0x10a/0x500
>>     sock_recvmsg+0x168/0x1d0
>>     __sys_recvfrom+0x19a/0x2a0
>>     __x64_sys_recvfrom+0xe4/0x1f0
>>     do_syscall_64+0xf7/0x530
>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>>    cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
>>    WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
>>    Call Trace:
>>     tcp_recvmsg_locked+0x8d1/0x2640
>>     tcp_recvmsg+0x10a/0x500
>>     sock_recvmsg+0x168/0x1d0
>>     __sys_recvfrom+0x19a/0x2a0
>>     __x64_sys_recvfrom+0xe4/0x1f0
>>     do_syscall_64+0xf7/0x530
>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Fix this by checking if the redirect destination is the same socket.
>> For self-redirect (dst == psock->sk), skip tcp_eat_skb() since the
>> copied_seq will be advanced when the data is actually read from the
>> ingress queue. For cross-socket redirects, tcp_eat_skb() is still
>> needed to account for data leaving the source socket.
>>
>> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>> Hi,
>>
>> I encountered this while adding MPTCP BPF sockmap support. The existing
>> TCP sockmap selftests don't cover self-redirect, but the MPTCP tests do,
>> exposing this latent issue.
>>
>> With this fix, both TCP and MPTCP tests pass, validating self-redirect
>> functionality.
>> ---
>>   net/core/skmsg.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index 2521b643fa05..5fa7b9639eef 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -1039,10 +1039,14 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
>>   				goto out_free;
>>   		}
>>   		break;
>> -	case __SK_REDIRECT:
>> -		tcp_eat_skb(psock->sk, skb);
>> +	case __SK_REDIRECT: {
>> +		struct sock *dst = skb_bpf_redirect_fetch(skb);
>> +
>> +		if (dst != psock->sk)
>> +			tcp_eat_skb(psock->sk, skb);
>>   		err = sk_psock_skb_redirect(psock, skb);
>>   		break;
>> +	}
>>   	case __SK_DROP:
>>   	default:
>>   out_free:
> Isn't the source of problem on the read-side (tcp_bpf_recvmsg_parser)?


Right, I think I already fixed the parser side.


> We should be advancing copied_seq only for skbs that we received from
> the tcp stack. That's why we have the copied_from_self detection in
> tcp_bpf_recvmsg_parser.
>
> I think the problem is that we set msg->sk when we call
> sk_psock_skb_ingress_self from sk_psock_skb_ingress, so on SK_REDIRECT
> path, not the SK_PASS path.


I sucessfully use this selftest to reproduce the splat:

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c 
b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1fef6ec2ba7a..58a90f2e3602 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1173,6 +1173,15 @@ static void test_sockmap_copied_seq(bool strp)
         if (!ASSERT_OK(err, "bpf_map_update_elem(p1)"))
                 goto end;

+       /* self redirect: data sent by c1 is redirected back to p1 itself */
+       sent = xsend(c1, buf, sizeof(buf), 0);
+       if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c1), self"))
+               goto end;
+
+       recvd = recv_timeout(p1, rcv, sizeof(buf), MSG_DONTWAIT, 1);
+       if (!ASSERT_EQ(recvd, sent, "recv_timeout(p1), self"))
+               goto end;
+
         /* just trigger sockamp: data sent by c0 will be received by p1 */
         sent = xsend(c0, buf, sizeof(buf), 0);
         if (!ASSERT_EQ(sent, sizeof(buf), "xsend(c0), bpf"))
@@ -1364,6 +1373,8 @@ static void test_sockmap_no_verdict_fionread(void)

  void test_sockmap_basic(void)
  {
+       test_sockmap_copied_seq(false);
+       return;
         if (test__start_subtest("sockmap create_update_free"))
test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
         if (test__start_subtest("sockhash create_update_free"))




> REDIRECT-to-self should really be a PASS, see [1]. My suggestion - fixup
> the verdict:
>
>          if (verdict == __SK_REDIRECT && skb->sk == psock->sk)
>                  verdict = __SK_PASS;


Agree. It's simple and clear.


+        if (verdict == __SK_REDIRECT && skb_bpf_ingress(skb) &&

+            skb_bpf_redirect_fetch(skb) == psock->sk)
+                verdict = __SK_PASS;

         switch (verdict) {


> Then we can remove the sk_psock_skb_ingress_self call from
> sk_psock_skb_ingress, and kill take_ref param in
> sk_psock_skb_ingress_enqueue.
>
> John, Jiayuan, thoughts?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2443ca66676d50a4eb3305c236bccd84a9828ce2
