Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC5333730
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884063; cv=none; b=GWnOILGiDERv5S0Huu7t/81caXtuQBrCz0JSwbLM936CJYpNWfyYSr0MA0GNfS3+ubjC6F+up91GJRajBQsj+pzgwGFSQJUN0lTdN7zVJ6AkRSgPCqEMtMYIRvqCQG8OFhi7ngGECqqjestHYoXTNfcR9tJecpehvS0+GS/tYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884063; c=relaxed/simple;
	bh=dDsO5uf2WRZSDWmo+4MqP6v9u8prPHyFuGugSzJiXms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SOiq0M29OID21qnR0BEPi6gPudtRkd64HKTHEnFcY1yu56zNgtBNx0eH42qEKzr55Zzu3Qx/27YyD69TYmqYNo1VIFuhs/xWbTaBSm4+mlBK+f6CkjpS9wYOPzb8Th8rcWUgDHQNtg4oKU9nN7hfzuX83MpoexREHfsD497XtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4juGaDY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4juGaDY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so3247112f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774884060; x=1775488860; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlR8hdQRwntlpv8tuo2N0ezyr91wv9YgNBgco65NDoE=;
        b=V4juGaDY3c7eljcojk+PgfK2bI9WmRrM5/Lim8rxp+VArI7upsgdL8TYqCPbNCD+I5
         UtwDRNtb6+QoXLBHv+M97MOML7Zlau3IZm9dcHxtHmoSLDK0vlIq8A7GCEOCl3DajzoM
         koGKi+kxsQpLa/y6VH50RyQ9HGHRahhhcY5G17oVe8D6kZ6RKcXPLBht0eopXuPHXROn
         hFhABuhoN1w4fZkPY3v/iCYjWCS0xOlYZX86/DSSC9W0/Bay/8BwB/D2NcYiB/5dUbaA
         ylHt13UuM7w1W3apABnig9whNtKy6UUo+lqMtmfkfFauqQeV78WswT59ncblH5bvx12V
         t/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884060; x=1775488860;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlR8hdQRwntlpv8tuo2N0ezyr91wv9YgNBgco65NDoE=;
        b=REk97HLrj8kRje8st7k0ynl6rpshDpnLQe5+KHYJobKnc+DrbzemXTOwIBxssxi3Dx
         wvJCOWLNFpAz8fsJYODhMHpsOCIG8JpL4XjwQ3Uwx579pyQna9Lc1xkZb2WnNqGEiOl7
         oJsSVZTzpcytn0Lbc2GAJwZMGx1Y7TrZMWp3umH4ygPEPlkFG1CyOCRXde96dGZrEx8k
         OngzxURAgBB9dtmAUTd4jhOtmarC9fcLBmO+W/xnOC0Jcgrv1whnxOaQox5zznk+eXn1
         8P+VhYwnu7QcOlP4v5h99PWrJbbNVTw5R0/rHnsz4TQA7xi5kH0u6RtJSI1+od7JSVwi
         6a1w==
X-Gm-Message-State: AOJu0Yxd12dXi5FLU7yg+vgwQDtai020C6QzOJ/qIzh4+qh202Oq+KUR
	5qosFGCEygMx2bESgl9OXZDQ6Ly1rgzRA89ucfY1HM9D92NnrIgFnW4h
X-Gm-Gg: ATEYQzxW6k3VWosHE3Qbx1bu4Fdfm/dAwZeqL51lthLkZ8Du5Wox8+62KyBy1wSVw7U
	ui8OiW5SLuvAKOmR+OZatJVmpyUhb1uyJZBG+F9Ng6cGbfQEyw457idADUf7dhrhWHYUiaDFnLO
	1igZp0Waw9Vr1mY1KWJHHqRkcGllYu9gxCPfK6FndDGRDOV6tG+1+zVgvz7pq3WZLGofMb/5Wvd
	6yBQq6l+AOKb1LeLaoT9sQ11SZxDd1R1VSiBD38ckx6aRcIUKdfsxTwQqrh7TBpoaQU63uTdKOh
	h8tpyJr0rfrV7jBA3q979vDBpzNcqkMF1I5KZhP6Z4QG9XCKvV76atnrj6YSNSUBj/Lb8P5Kaf2
	vWKMcmix4S0Ev6zOGYRGaQPZUz7ZAeUf1euNmHqMrO/EfGWR8rwcvWP6yvLHzFheKE3//5mBN65
	yFwvlokl+BxOe+eCU=
X-Received: by 2002:a5d:5d01:0:b0:43b:9c73:2933 with SMTP id ffacd0b85a97d-43b9ea34811mr22655564f8f.15.1774884056423;
        Mon, 30 Mar 2026 08:20:56 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:4b08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2487sm20593730f8f.5.2026.03.30.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:20:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
In-Reply-To: <20260329140506.9595-2-pilgrimtao@gmail.com>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
 <20260329140506.9595-2-pilgrimtao@gmail.com>
Date: Mon, 30 Mar 2026 16:20:50 +0100
Message-ID: <87ikadgx7x.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chengkaitao <pilgrimtao@gmail.com> writes:

> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Replace per-kfunc btf_id chains check with btf_id_in_kfunc_table() and
> static kfunc tables for easier maintenance.
>
> Prepare for future extensions to the bpf_list API family.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

I think old is_bpf_rbtree_api_kfunc(kfunc_btf_id) is more readable than new
btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_api_kfuncs);
Not sure if this change should be bundled with this series, it looks
quite orthogonal.

>  kernel/bpf/verifier.c | 261 +++++++++++++++++++++++-------------------
>  1 file changed, 144 insertions(+), 117 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4fbacd2149cd..f2d9863bb290 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -544,9 +544,6 @@ static bool is_async_callback_calling_kfunc(u32 btf_id);
>  static bool is_callback_calling_kfunc(u32 btf_id);
>  static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
>  
> -static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
> -static bool is_task_work_add_kfunc(u32 func_id);
> -
>  static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
>  {
>  	return func_id == BPF_FUNC_for_each_map_elem ||
> @@ -586,7 +583,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
>  
>  	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
>  	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
> -	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
> +	    is_async_callback_calling_kfunc(insn->imm))
>  		return true;
>  
>  	verifier_bug(env, "unhandled async callback in is_async_cb_sleepable");
> @@ -11203,31 +11200,6 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> ...
> -- 
> 2.50.1 (Apple Git-155)
