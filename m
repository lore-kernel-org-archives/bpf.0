Received: from mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED013CF662
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233598; cv=none; b=f0XkxqJzPrrRcs15QSKBdsr7nYTTrKDShtbkOVc3kIItAOw7BRiUOsifaM6gW5sGC10BzNvzSEqDhhYeAnFdgtOsR9plwZocmxa5kuPnlwkkSuq6/QD1KavzWCaLbBtuoD457LjtusxmOxFJUhzvCyhVf+5XOsQPLuLQ6G5SPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233598; c=relaxed/simple;
	bh=1sXABWoGOH2SxMnOcmCrWnJpfHh44pyFY8wQ+xC7Vkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo0bCDKciGZYouk37y8j6lTiCJ4lvuBeB2KVxhtvTo4fosH+rH4bMBkFyJ44gI5X+FB22hScmiaLBlDsFiYebM8XYxK5sAsFTHlc86BLJHeNQI5voqmGf2QgCEioBofEVZTK37U6cHNBH2WDaXQXCuodi3A2K7WVq6ZSbtmmKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OPOYkV/o; arc=none smtp.client-ip=91.218.175.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OPOYkV/o"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1sXABWoGOH2SxMnOcmCrWnJpfHh44pyFY8wQ+xC7Vkc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790233590; v=1; x=1790838390;
 b=OPOYkV/oaiDRSLE6BEDErz41vnbceJ8Rg36kKQeg1286M03PrHDlNSGutntduB/vwJJyQPW/
 icXd0m8QVD5Bzx4nShDQzSD8ZUulLh04EpYTS39v7H3yqwfQRzSAo2WFIT+ZqGEsUQqXAuB4zdv
 w4p5J6xXi6mxlBy3QA3zmtjM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef1e18f4a410e785;
	Thu, 24 Sep 2026 07:06:20 +0000
X-Mizu-Trace-ID: ef1e18f4a410e785
X-Migadu-Flow: FLOW_OUT
Message-ID: <d3e65c94-45d9-4c67-a276-103c5e7fa052@linux.dev>
Date: Thu, 24 Sep 2026 15:06:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Keep target extended until its last
 freplace link detaches
To: chenyuan_fl@163.com, alexei.starovoitov@gmail.com, ast@kernel.org,
 leon.hwang@linux.dev
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 yonghong.song@linux.dev, john.fastabend@gmail.com, song@kernel.org,
 ihor.solodrai@linux.dev, Yuan Chen <chenyuan@kylinos.cn>
References: <20260924023737.1140521-1-chenyuan_fl@163.com>
 <20260924023737.1140521-2-chenyuan_fl@163.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260924023737.1140521-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/9/26 10:37, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> The is_extended / prog_array_member_cnt protocol introduced by commit
> d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
> keeps a prog extended by a freplace program out of prog_array maps, and
> vice versa: once a tail call re-enters an extended subprogram, its
> tail_call_cnt resets on every execution and the loop never terminates.
> 
> But is_extended is a plain boolean, while one target prog can carry
> several freplace links at the same time, one on its entry and one on a
> global subprogram.  __bpf_trampoline_unlink_prog() cleared is_extended
> whenever *any* freplace link detached, so detaching one of two links
> re-armed the unbounded loop through the remaining one.

A prog may have multiple global subprogs. And each of the subprogs can
be attached with freplace prog. When all the subprogs are attached with
freplace progs then detach one of the freplace prog, the *is_extended*
becomes *false*, which relaxes the restriction between tailcall and
freplace introduced by the commit d6083f040d5d ("bpf: Prevent tailcall
infinite loop caused by freplace").

> 
> Replace the is_extended boolean with a count of the freplace links
> attached to each target prog, so the target stays extended until its
> last link detaches.  Also rename bpf_freplace_check_tgt_prog() to
> bpf_freplace_link_tgt_prog(), as the helper has never been a pure
> check: it reserves the target prog on success.
> 
> Fixes: d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> 

[...]

> @@ -933,7 +933,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
>  		/* Cannot attach extension if fentry/fexit are in use. */
>  		if (cnt)
>  			return -EBUSY;
> -		err = bpf_freplace_check_tgt_prog(tgt_prog);
> +		err = bpf_freplace_link_tgt_prog(tgt_prog);
>  		if (err)
>  			return err;
>  		tr->extension_prog = node->link->prog;

                return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
                                          BPF_MOD_JUMP, NULL,
                                          node->link->prog->bpf_func);


I think there are existing issues here: if bpf_arch_text_poke() returns
error, the tr->extension_prog and aux->freplace_link_cnt should be
rollbacked.

Thanks,
Leon

> @@ -979,7 +979,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
>  					 tr->extension_prog->bpf_func, NULL);
>  		tr->extension_prog = NULL;
>  		guard(mutex)(&tgt_prog->aux->ext_mutex);
> -		tgt_prog->aux->is_extended = false;
> +		tgt_prog->aux->freplace_link_cnt--;
>  		return err;
>  	}
>  	bpf_trampoline_remove_prog(tr, node);

