Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447632;
	b=eLD3/epKSy1G3zeBq0p/rPUVAf44stciEzjzvMYH4ukFA3WWE9FAlp9lIx6b/OJI/gYG
	 jlllLNGqWhVUWhYfxmnChO1+FX7Zx/2VTTzZ1KJ3wiFzC4kt9coXsKqLLihpgvNOkEfTP
	 lyOtRg0svahYSKao4SvdX3UG05wW25oOSRbVV/IFQhSwJJT6kyGCW7dY6q06fJi50A9nR
	 qKSgpvJpIdPQ704zUmBja61BbT7libETa/Jj4/hF6MRRVbzw1fAKzH0t6CG0J8n5jKDWg
	 D1m8z+/D2vTDK+HVwL2Naqtp7FdtSMKQh+uYWpOJCZuUPtAmDE1NY1l5If9WfSacWFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447632;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TLmU0zCU5pqSaqfVN81bq9IYO9jaYJz+0tuGU5ooGj0=;
	b=vaj67/q0cYMJPAYtGIsjtn73icjfEkEWHSPg/dm7/T9BPKoGYNX4RTTQi5hBwqFj6Efc
	 29xOjoxJW9P1O7c4DpJU5gMQCrHvkMa8TsJwyGS0EUX9MfQGsrBQZxJTWpH+O6hUqHbn/
	 EYuG5yn8e56znvswsAy0LhOBUTB7WVgoA7quQdMVoQ3sJdBska7WtrYurToKWqQlXUB1F
	 occsYZgHH61gO0fxT3avmfj1ISCQNiDjKsmX7bTvDdZ1/U6VwURe0yi/hJJEC8m7qfzfA
	 9f823Bj+SdLUsVZwoJJcbsG7yVJ13GV6jRlYpgw+B9WDztTQ+FVaIZAz6WD2FiW/xuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D265F606A324;
	Thu, 12 Nov 2026 01:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D265F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 07ba000ade3a11f19a56ed5b684f684d-20261112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a45ceaec-e4ad-48e8-9635-81a454928b53,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:7c6b00ed8ad170562809c94a1ee2c01e,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 07ba000ade3a11f19a56ed5b684f684d-20261112
X-User: weirongguang@kylinos.cn
Received: from [10.42.124.137] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 731677355; Thu, 12 Nov 2026 09:40:24 +0800
Message-ID: <d105b2a4-952c-47d8-a1d6-2d3ae63d5c1c@kylinos.cn>
Date: Thu, 12 Nov 2026 09:40:21 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v10 1/2] tun: keep a kernel copy of the socket filter
 program
To: netdev-bot+sashiko@kernel.org, clementwei90@163.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 willemb@google.com
References: <20261109023848.59575-2-clementwei90@163.com>
 <179442971051.2199510.17461948089232677295@kernel.org>
Content-Language: en-US
From: weirongguang <weirongguang@kylinos.cn>
In-Reply-To: <179442971051.2199510.17461948089232677295@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> > If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] TUNATTACHFILTER on a device with zero enabled queues saves a
>   program that has never been built.
> - [Medium] After a partial TUNATTACHFILTER failure, the device's recorded
>   filter state no longer matches what the queues enforce, and the reason…
> 
> --
> 
Thanks for the review.
> tun: keep a kernel copy of the socket filter program
> 
> This patch makes TUNATTACHFILTER keep a kernel copy of the classic BPF
> instructions in tun->fprog_kern. Each queue gets its own program, built
> from that copy with the new sk_attach_filter_kern() helper. The patch
> also fixes the inverted error check in tun_attach(), and checks the
> program with the new bpf_prog_validate_classic() before the saved filter
> is replaced.
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index dcec7311e6011..67c8b74d59bde 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
> 
> [ ... ]
> 
>> @@ -3091,15 +3166,29 @@ static int tun_attach_filter(struct tun_struct *tun)
>>  	for (i = 0; i < tun->numqueues; i++) {
>>  		tfile = rtnl_dereference(tun->tfiles[i]);
>>  		lock_sock(tfile->socket.sk);
>> -		ret = sk_attach_filter(&tun->fprog, tfile->socket.sk);
>> +		ret = sk_attach_filter_kern(fprog_kern, tfile->socket.sk);
>>  		release_sock(tfile->socket.sk);
>> -		if (ret) {
>> -			tun_detach_filter(tun, i);
>> -			return ret;
>> -		}
>> +		if (ret)
>> +			goto out_detach;
>>  	}
>>  
>>  	tun->filter_attached = true;
>> +	return 0;
> 
> [Severity: Medium]
> What happens here when tun->numqueues is 0?
> 
> The loop body never runs, so bpf_prog_create() is never called on the new
> program. Even so, filter_attached is set, and the TUNATTACHFILTER case in
> __tun_chr_ioctl() commits the program:
> 
> 	kfree(tun->fprog_kern.filter);
> 	tun->fprog_kern = fprog_kern;
> 	tun->fprog = fprog;
> 
> tun_copy_filter() only runs bpf_prog_validate_classic(). A program can pass
> that check and still be refused later by bpf_convert_filter(), when a
> converted jump offset falls outside the s16 range. It can also be refused
> by bpf_prog_select_runtime(), which returns -ENOTSUPP when a JIT is
> required but cannot be used.
> 
> A usable fd with numqueues == 0 looks reachable on a multiqueue TAP.
> tun_set_queue() lets IFF_DETACH_QUEUE detach every queue, and
> __tun_detach(tfile, false) keeps tfile->tun. A detached fd can therefore
> still issue TUNATTACHFILTER.
> 
> The inverted check in tun_attach() is now fixed:
> 
> 	err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
> 	release_sock(tfile->socket.sk);
> 	if (err)
> 		goto out;
> 
> With that fix, wouldn't every later IFF_ATTACH_QUEUE on this persistent
> device fail? The same goes for every TUNSETIFF without IFF_NOFILTER.
> Before the patch, a new tfile in this situation still attached.
> 
> The commit message says "Such a late failure does not replace the saved
> program". Here, though, the program is saved without ever being built, so
> the late failure happens on every later queue attach instead.
> 
> Could the program be built once with bpf_prog_create() even when there
> are no queues to attach it to?
> 
The program is stored only after it passed the classic verifier, and a
program that is refused later, when it is built, only makes the attach fail:
nothing is left half-installed, and TUNATTACHFILTER can be reissued with a
valid program. Building it once in tun_attach_filter() when there are no
queues would just move the same failure earlier in the ioctl; it would not
make the program installable. The commit message sentence is vacuous in that
case, not wrong: the intent is that a failed build does not replace the saved
program, not that the stored copy has necessarily been built.
>> +
>> +out_detach:
>> +	/* Drop the copies already installed on queues 0..i-1, which leaves
>> +	 * them without a filter: their previous sk_filter, if any, was
>> +	 * already replaced and released. The caller does not replace the
>> +	 * saved program when this fails, so tun->fprog, tun->fprog_kern and
>> +	 * filter_attached keep their previous values.
>> +	 */
>> +	while (i--) {
>> +		tfile = rtnl_dereference(tun->tfiles[i]);
>> +		lock_sock(tfile->socket.sk);
>> +		sk_detach_filter(tfile->socket.sk);
>> +		release_sock(tfile->socket.sk);
>> +	}
> 
> [Severity: Medium]
> Does this rollback leave the device's filter state out of sync with what
> the queues actually enforce?
> 
> Suppose filter P is attached on every queue, and a new TUNATTACHFILTER
> fails on queue i > 0. On queues 0..i-1, __sk_attach_prog() has already
> replaced and released P. This loop then detaches those queues, so they
> run no filter at all. Queues i..n-1 still run P.
> 
> tun->fprog, tun->fprog_kern and filter_attached keep their old values, so
> TUNGETFILTER still reports P. tun_attach() also installs P on queues
> attached later. Meanwhile, queues 0..i-1 pass every packet through
> sk_filter() unfiltered.
> 
> Before the patch, tun_detach_filter(tun, i) cleared filter_attached on
> this path. The device therefore did not claim a filter that some of its
> queues lacked.
> 
> The commit message says:
> 
>     A queue that
>     already took the copy is rolled back, which leaves it without a filter,
>     because the program it ran before was already released; restoring it
>     would need an extra reference per queue.
> 
> Is that accurate? P's instructions are still in tun->fprog_kern. It looks
> like sk_attach_filter_kern(&tun->fprog_kern, sk) could rebuild P on queues
> 0..i-1, the same way tun_attach() does for new queues. Another option
> would be to clear the saved state when the attach fails partway.
> 
This is not a state introduced here. Before this series the same failure ran
tun_detach_filter(tun, i), which also left queues 0..i-1 without a filter,
queues i..n-1 on the old program, and cleared filter_attached while
tun->fprog already held the new header. What this series changes is that
tun->fprog, tun->fprog_kern and filter_attached keep describing the program
queues i..n-1 still run, so a later attach retries it instead of silently
starting without a filter.

Rebuilding from tun->fprog_kern would not remove the failure:
__sk_attach_prog() uncharges the old sk_filter as soon as the replacement is
installed, so queues 0..i-1 no longer hold it, and the rebuild is a new
bpf_prog_create() on the path where that allocation, the optmem charge or
the JIT limit has just failed. It needs a fallback of its own. Building and
charging every program before swapping any of them in would require
splitting __sk_attach_prog(), which is a filter core change, not something to
mix into this fix.

Both are error paths of TUNATTACHFILTER with no corruption outside the
device, so I would leave them as they are.
> A failure partway through the loop looks reachable in several ways:
> 
>   - -ENOMEM from bpf_prog_alloc(), or from kmalloc_obj() in
>     __sk_attach_prog()
>   - the per-socket optmem check in __sk_filter_charge()
>   - under CONFIG_BPF_JIT_ALWAYS_ON, bpf_jit_limit being reached partway
>     through, because each queue JITs its own copy
> 
