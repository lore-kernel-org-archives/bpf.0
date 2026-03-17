Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AB2EF67A
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767953; cv=none; b=tg0rxiZ19/5TlGw7+GsdD8+rZImwo0N38skWgnJetU4SUqDuCLUBbDDgGL4Kymnlg8x0AqYhyCVoM9JmXM03FbDHpWZDPaGmTmeZcGQ+04LTb4BaqDxrd425iehwyBlIWpsF83BcMEkuv25GNdvIzK1GHjem51cW3u/mliSQfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767953; c=relaxed/simple;
	bh=2hjbNahnuGBtCGAjVVmPWGi9vjAppdFkWpEZ/Vxf4bs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN+WaUttBpvGFDdLI9p+6+yQ42Vp1zPai5rlxB/FHc952fOzBrpGcMTBNNvTTHp8FNMTy06xh6q54Cmy7eTFuhfsuIdUVkKG0Nbk/FRDEtxSGccYie8rUSA7i9gAs1to8O+LCyvB8HnrhAYPdN236Qv4yFYCkGkxY9CfK16Cup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYaNiti4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYaNiti4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so70409155e9.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767950; x=1774372750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeIlA9ZrszPT24xZdT0RmPKncmN7mk/8Vz4jMnUZCWw=;
        b=NYaNiti4JugbUg0W/O5i0o3HSkG5c+4rTzblAKi3XLgxOYi2hzRlQ7Jn4Sw3L1Fvd/
         Ly9X6JNrD03NTm/2Xzg+3Uy0A6KeWivDXVVpWGR8/44QHkX+EXeqmnj2UGBGQ4TUkzQP
         7NTNuC14AVFAok2HTGKnXoOYvGb9JAnKXncRvaX5ROwae5/Mj8Q70/fS39fu3sVEBds0
         BT1WkKWS3qaDQWZ3+1dFDrOd5s6QS8k5rQuo0a5BwqK0vZgc0Rrj1eomM8yJgKrOB/oM
         mHE9eZnkMUVDAjfrYYFT0qotZPEzi44ezcX+W69NQ9U3B1ueWGtpc5751dhDuw09mG/x
         ZIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767950; x=1774372750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeIlA9ZrszPT24xZdT0RmPKncmN7mk/8Vz4jMnUZCWw=;
        b=hxVrBgEnPZ3GWKqeO7x6dgfFthGEYK7WzFCkauhQidtMlvvN4XjVGqG2ssz7Ge0yT0
         hFODnU1HFBFdLF5O5swlQWHenP6UO+vIGYHRhE4r8EdDJw8xdhAW7xOyQN7XjRrI9ScB
         JBJ7uSAIsdLgGpOV4CR8tHCSX0vdYGbY+7FquLye2ZZ+aMyIMnO52+8BVRQARq6WUkJX
         5ZhRmKm5EHhx/Ew3e377neKT5RZgNyLyaL5bQEchUHqxfXwG+fRcMBJm9fNWkQi3MJp/
         bADvHT6pRj0aK7fk1D0DdoeVSc/gGulZoK4BY4Uw9gSPoJthucvfq5o2yACLjU0lMP0c
         b+KA==
X-Forwarded-Encrypted: i=1; AJvYcCV0UwTD3GeT4Ro195BEXxV0EYdFqgB8YH0LlAR8g4car3vk21ID+J2QQ//pkae2lKI2toE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySluZlbkfDRXGV+ZzriQoS/v5z8qMlZvOiLrNwq1N3GbPSZAb
	Kehk9nIN749BgcX8hMqBwZanDud3G5+INVZvTYSwNrf89yklCUlubPD7
X-Gm-Gg: ATEYQzzzen2DVIv6EAgl4vbLFvM/Daf5A+9kNlr/RXiu/X2yDPvIYtuPju25OrViZpM
	bIQIEs+W36frkQ6vcWnipXvaMNIgNtDbiXAOQu27rLQ6TRsIiyCt5xc8I7PJDQyeWJw962NKn6m
	wkoO0B8r911BkAIEzs5op0Z7Z5uW2w2twcF1x/EOJjUEiaro8jUY2gA0w8Zo1i49gNSMvDuXNKo
	3levoO4GfOIFVQyXWhlbytdeS8UnWf9V/Hgr8fEO71I633RkS6R6vQoxpviT74xYZ6rWPRtb6y1
	LD+52+SlMRE+gnvJqvqTomnL2EPu0QeoTIgtoaj4lpIdPDhIcU3Y3usGlxnHiFuPm7VMua7q/Vw
	fStDkeRYaAYv0AI86DdZcqWebCGAtpNUrW1Efg5JUQxa5lyyNphVozCuiSRLOxHOsRWi9LDGbdR
	k0b10jIADj3F/WqSoleZrE1Q==
X-Received: by 2002:a05:600c:c8d:b0:485:4006:960c with SMTP id 5b1f17b1804b1-486f446b02bmr5174455e9.16.1773767949913;
        Tue, 17 Mar 2026 10:19:09 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3396sm77364765e9.9.2026.03.17.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:19:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:19:07 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 22/24] selftests/bpf: Add tracing multi attach
 fails test
Message-ID: <abmNCxhibVFIZMpQ@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-23-jolsa@kernel.org>
 <58218abd-dc9e-4197-93eb-5bd0d6c99863@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58218abd-dc9e-4197-93eb-5bd0d6c99863@linux.dev>

On Tue, Mar 17, 2026 at 11:06:58AM +0800, Leon Hwang wrote:

SNIP

> > +	/* fail#3 pattern and cookies */
> > +	opts.ids = NULL;
> > +	opts.cnt = 2;
> > +	opts.cookies = cookies;
> > +
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +						"bpf_fentry_test*", &opts);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	/* fail#4 bogus pattern */
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +						"bpf_not_really_a_function*", NULL);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	/* fail#5 abnormal cnt */
> > +	opts.ids = ids;
> > +	opts.cnt = INT_MAX;
> > +
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +						NULL, &opts);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	/* fail#6 attach sleepable program to not-allowed function */
> > +	ids2 = get_ids(func, 1, NULL);
> > +	if (!ASSERT_OK_PTR(ids, "get_ids"))
>                            ^ ids2 ?

yes

> 
> > +		goto cleanup;
> > +
> > +	opts.ids = ids2;
> > +	opts.cnt = 1;
> > +
> > +	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
> > +						NULL, &opts);
> > +	ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi");
>                                    ^ test_fentry_s ?

yes, will fix, thnx

jirka
