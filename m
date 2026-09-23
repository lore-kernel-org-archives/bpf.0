Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7847D956
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157285; cv=none; b=G4sOnjYFqpEIh2UYJOoNzQBo4X76yG6GDSAX6iOqAz3QIUfIgghG/vtGXb/0i93OP3p3W47nqGeCrM5dFJk1wddGL04PiQTTB9Jb8TO8ridZuhSyF0Iy53WUWo7bxg5wR20lYJ0hOlWvfQipuZSWqDhEQhVLNJmvSe2RTsKRLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157285; c=relaxed/simple;
	bh=wZUoP4FuiHaQwyQE/qC2hfUw+ONE9OqaXvgOriAyrMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiHCnbBfoJH68Ck4KOdGqTuXz5E44QMV7o+C02+hP0AOmM4fLC49KenVstoQkPo7HWQ3Rgw8P+TMLU05mz2TyzfpD17aLafUDDm26iw0w5OLH1rOd31Scnas40si9pdmXUSiVbhN0ga9E7QIMkNFCqBnvYJ+M1YaPdhcI+lT3wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t3lK2z5Y; arc=none smtp.client-ip=91.218.175.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t3lK2z5Y"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wZUoP4FuiHaQwyQE/qC2hfUw+ONE9OqaXvgOriAyrMk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790157279; v=1; x=1790762079;
 b=t3lK2z5YiPWMIhC8sLTZJMyAc3OKMa0LqI20Nlt6uG4ZtOFcvo3fxux9DuUWVxiRNNOpcEFO
 kkusSUAvJwl4nS2CZ7gg5+SJ+SV+aLrHxZU2Co3kY9sORyMJnCH4+ezqY9Bx3rWIqv+bHkZP519
 B8d4B5oxMuU4i6nbT1DKMuk8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fc06004bceb9ed48;
	Wed, 23 Sep 2026 09:54:39 +0000
X-Mizu-Trace-ID: fc06004bceb9ed48
X-Migadu-Flow: FLOW_OUT
Message-ID: <ee0a1126-9ff2-4a08-8f13-4af366ebe28a@linux.dev>
Date: Wed, 23 Sep 2026 17:54:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Keep target extended until its last
 freplace link detaches
To: chenyuan_fl@163.com, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Yuan Chen <chenyuan@kylinos.cn>
References: <20260923090635.368488-1-chenyuan_fl@163.com>
 <20260923090635.368488-2-chenyuan_fl@163.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260923090635.368488-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/9/26 17:06, chenyuan_fl@163.com wrote:
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
> 
> Replace the is_extended boolean with a count of the freplace links
> attached to each target prog, so the target stays extended until its
> last link detaches.  Also rename bpf_freplace_check_tgt_prog() to
> bpf_freplace_link_tgt_prog(), as the helper has never been a pure
> check: it reserves the target prog on success.
> 
> Fixes: d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")

You should cc me when posting the next revision.

You can get the cc list by ./scripts/get_maintainer.pl /path/to/file.patch.

> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  include/linux/bpf.h     |  4 ++--
>  kernel/bpf/arraymap.c   |  2 +-
>  kernel/bpf/trampoline.c | 10 ++++++----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 

[...]

>  
> @@ -933,7 +933,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
>  		/* Cannot attach extension if fentry/fexit are in use. */
>  		if (cnt)
>  			return -EBUSY;
> -		err = bpf_freplace_check_tgt_prog(tgt_prog);
> +		err = bpf_freplace_link_tgt_prog(tgt_prog);
>  		if (err)
>  			return err;
>  		tr->extension_prog = node->link->prog;
> @@ -979,7 +979,9 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
>  					 tr->extension_prog->bpf_func, NULL);
>  		tr->extension_prog = NULL;
>  		guard(mutex)(&tgt_prog->aux->ext_mutex);
> -		tgt_prog->aux->is_extended = false;
> +		if (WARN_ON_ONCE(!tgt_prog->aux->freplace_link_cnt))

Is this WARN_ON_ONCE() necessary?

Thanks,
Leon

> +			return err;
> +		tgt_prog->aux->freplace_link_cnt--;
>  		return err;
>  	}
>  	bpf_trampoline_remove_prog(tr, node);

