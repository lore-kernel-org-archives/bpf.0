Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699D30B53A
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560029; cv=none; b=b1q8MaKWBy975Xl+ubLGZw9cTR4RQEiucjQ93Fuy2idRE/qIXDssxmvd+YPszs53u9WnHZ+kHUDkjpQLbZ7r8BgNriBG3Gn4XN6JDkX2noE1Mq4WOy49wYOLvKrxFx8k/EIlmxxw4z8rAxW5kkKN5qGCRNvfo3O5plUV8E+lRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560029; c=relaxed/simple;
	bh=tLNBjb1LxGgsWGmcE25Qk72vSCilUGhydTgk7Zym6qg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3p6nU+fz+Po6IHkT8uJwfU1zP51b6x0SWHNFUbB/k7j8g7uzz4jO5pjw1/EjQ1NiUB0Jp+Fb14AyWDr7psaVh3/ZO7dRzg1a8lgdGeZnoenLZjqmyuVeYe52WrbgN4RGhXFb5Y/+jKKgG2O5KTtPq/n6PqVY6qvHPs1vo5P+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjvY75eA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjvY75eA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b3e03939so2913555e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560027; x=1781164827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5S/ODxVsZ0F1Hysh5uuXFztTRTMytWGdM0vjEW7pXv0=;
        b=YjvY75eADabUucunowoYWwHqVIXmxoS7hbodzR0L1O/gfSJ5DvEai8MqQqmms/QU04
         kYr0O6bTFoeu7/Cyr/ZsD+axvHsuf7Pc1dqhceEkEEuAFfRFaEF7o+2n3odGlSXSUZ0g
         m4sIorctztaxg399WRqgdqDckdK39aDf5zz0eN50n5ZmlYfHIr/T4y/AGs30IX8gn1Sk
         nOWgNIYQRWQFFcfu3iogyVLN17TO0Ficrffpgu5bk9xMFRHVhBluMA8dqnZB8KrZhF6g
         vE0yuWxST1vv6MXbSmrAxWewfH9YZhs+ymBra4UWJed58jDhvhK+rkHSzgC/y1iiIOot
         WV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560027; x=1781164827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S/ODxVsZ0F1Hysh5uuXFztTRTMytWGdM0vjEW7pXv0=;
        b=AZKqmPMGsiaCWuDO1jnS9Ej1mjJybALU6T2DRfHb/P63ssbqA8UHEfuKPcKLalG/t/
         pVT213/ZZPweatEWs32Hqh40g1EeXtwIbpPCGae8g5aoCroUrBrPohaxSA99c+x6Laqu
         Co4JKPgcvSGM9xWDiXR7ZCJzz5ASWwuL+loMSnSiAHKCeRKoCf9WxPY6T5BlooQeTMeX
         xMufIRaQoWZCck8lExbEQ+yfTu+5yTI2t3Glp+ejWmx8cQaHX0zqW/UPeaawIKBLD03n
         qq1bX2yg7urEi6ppCfO95HlGah/yPkMziDbWvnFrX9EzlReA03zlBT/oCZMwRNjvfntu
         dRYA==
X-Forwarded-Encrypted: i=1; AFNElJ92QHhH0e4fdz4tuca2G4AXWDOBpMkor9razvlwMfiwn4PicjxLskJ+5n5tQ4OvwQsYDV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6zRncrIkINIAcbBG0AquG5SHMvP0b5vFUIusXIaCZxuc7UKP
	twxNDHzmqD345xPvXbcE4cMzrWgWdstymYZI44WfKhbwD3pjkif56goh
X-Gm-Gg: Acq92OEAcZmxsp+64UayQtOXL2SaI5PPgCBUwdJWKwedXpCcncDKgEyoZbHI9EJkF41
	+WHvyMrsZswWc+3LOCOEGLtmrO5hTef2+jhO5akRLE9DM7dpXc3QCM+b9YI+gOk/llHHOvCM55G
	/yE2fte9j6wSH0fact878aH5WUpKQgi3eAsb3uE64y9hhlH3nQP3JUTf4Q1kVJtDb0d0BBvzPDW
	jf6k0QnH5rzJefnEEAXJlEtxmXOvbQE5jMd2nCOw1EhUMUOyRxOfusUajMRxc747FexyIRgDTas
	+98vjxk/N0BM3ZD/yV7hDAVHqJFkCHg5c11SDF4nAAZnbO7bsCod1gTT3OAukAMj1fTu1AIuQWV
	JNIxnavPBUzXIqWs6VKw4MqoAIahJBHhUc6GI8v7gw5N3Jeq4OJaQwM7AxgEsJbShhjY+G/PBt0
	h4PscNBapzjTD+QqGHP620KWyYKA==
X-Received: by 2002:a05:600c:6095:b0:490:bb60:68ca with SMTP id 5b1f17b1804b1-490bc4b54b4mr34914705e9.3.1780560026574;
        Thu, 04 Jun 2026 01:00:26 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm67383595e9.1.2026.06.04.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:00:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 10:00:23 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv7 bpf-next 13/29] bpf: Add support for tracing multi link
Message-ID: <aiEwl5axWo8_V7cR@krava>
References: <20260603110554.29590-14-jolsa@kernel.org>
 <6e738b0697b9ee06e9cbaa325a3330f0447f4cd12ae54d6b2c82365d58c4c525@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e738b0697b9ee06e9cbaa325a3330f0447f4cd12ae54d6b2c82365d58c4c525@mail.kernel.org>

On Wed, Jun 03, 2026 at 11:52:13AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index d853f97bd154..9e3cb547651e 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -42,6 +42,7 @@
> >
> >  #define MAX_UPROBE_MULTI_CNT (1U << 20)
> >  #define MAX_KPROBE_MULTI_CNT (1U << 20)
> > +#define MAX_TRACING_MULTI_CNT (1U << 20)
> 
> [ ... ]
> 
> > @@ -3641,3 +3642,132 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr
> 
> [ ... ]
> 
> > +static int check_dup_ids(u32 *ids, u32 cnt)
> > +{
> > +	int err = 0;
> > +
> > +	/*
> > +	 * Sort ids array (together with cookies array if defined)
> > +	 * and check it for duplicates. The ids and cookies arrays
> > +	 * are left sorted.
> > +	 */
> > +	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, NULL);
> 
> The sort here can run over up to MAX_TRACING_MULTI_CNT (1 << 20) elements
> without ever yielding the CPU. Can this hold the CPU long enough to trip
> RCU stalls or the soft lockup watchdog when cnt is large?
> 
> This was raised on an earlier posting of the series, with the suggestion
> to add a cond_resched() somewhere in the path. The reply noted that in
> practice the count is expected to be closer to 100k rather than the full
> 1M limit, and that it was unclear where the cond_resched() should go, so
> the code was left as is. Since MAX_TRACING_MULTI_CNT is still 1 << 20,
> would it be worth revisiting whether a reschedule point is needed here?

we now use sort_r_nonatomic which calls cond_resched,
I don't think loop below needs the cond_resched call

jirka

> 
> > +
> > +	for (int i = 1; i < cnt; i++) {
> > +		if (ids[i] == ids[i - 1]) {
> > +			err = -EINVAL;
> > +			break;
> > +		}
> > +	}
> > +	return err;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26881310426

