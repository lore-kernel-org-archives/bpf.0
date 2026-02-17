Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2E303A18
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365912; cv=none; b=V+EEXydL6ymP3qkzhoWoxSUqhow/XWG5EM2wUFad0Ce68R4AHLP1NsBjq5hQSN77kkYOq0cXcwvR14zbaKhBya+5ShI3otfjUEYaY8KVDjTpJ4q/oRizIi/1aCTae2oEgb2JDl/vz+IC2MwD+AX8ETdS0jBLnYVeHefKWKFLm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365912; c=relaxed/simple;
	bh=eRJGi/3EYvgsGuMw1/YWY8Hw9h/WwehRbzwbSM56p0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VICX9lMM08xvSmkZpjtpYs2a550jAKRVkfoL1E3FMMl4n/AH5lbMeTlH6n5Ab1ExQ8eFcbm/g8sP17yDCe/BkED/g3fVjGdk5dw5rGqeuRhfJ51zte1Vx7YkhDPx97n6FmRmpkrb8KMr3ji+vJ+AkYzSJVaxxjddt+LwaE01zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcI9987g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcI9987g"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so43913645e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365909; x=1771970709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pb9TCnVBIZiNkTZbCbry7FrvZQcTN63m7K6gzOiYf58=;
        b=EcI9987gTm7BTt0PGUJM5g79UR+3Td5Wx1IPiv6zE9t5lxMLDyfDpMB52h6Io+Ox1S
         lnW4n9vmqd2T6EpaYbhTyYrezW/sqB0dANvcW5p9KmWdOhukhPhGHMsZncluuomCYapV
         zwe0YO+dWPhmzcrJGSSEfTXlmlYxq2WBTLURQCPiOZ6iOvnh0G6lkvfwUTn57bDjh463
         XBQ7l68kLMe+Nm8fabl+pkWhqxPRtC/mGBhPOp2tUpDBYT3vIKDeisoLroC0mvui5C0/
         +p9hOBKnAS4ehLcMHykGB0wwbdgQOTef00OlW2IKEkbiJ2T+SOxaBzZXCPFZgipx2bKu
         wlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365909; x=1771970709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb9TCnVBIZiNkTZbCbry7FrvZQcTN63m7K6gzOiYf58=;
        b=Q4v78ZvqE3fptxveTsP0YBP0JNwnb4PTE4ZHUTMQ/wECPQccSIRQMRBQm6PU8kTsF2
         2GaVmKuWfa/RNnZTATnAOLvQ8EIY9CsT+A+kVIUhT1Sv3gMwIkgMf9kPhxPUmal/NjST
         oI7HZ8dG9GRQkKYEsTU19t1Ju8cEx0j9RFxA72IusQo7jP+DWOfZ6bMyXOSDwz1hvr0L
         9cRz/vvxeshfAtQ1U0nEf0AhSBdlJDYUhxdvIP4lIOm9pSJ+2FTjgxkUbO3HB0dwVuck
         MpWzZIzkQrrR8EoxtTWIQA+Pc89P6ol5VZB/Jl0wb+VnfHJYk9ou8mfbRYZPFW56H/Qi
         EqWg==
X-Forwarded-Encrypted: i=1; AJvYcCU1HmhR5rXzkRvJQYp5NEDDWOtrD6qXMwfacs7Cjqb/vyzeRN3ukUeuPngLRpMN0x91T+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzxah+mvewDWt65Ep3uVbUwDWGZECkWaifTV2jy3SJFhZblgqt
	t1Xiy8ieanT4k8u4Dju7sRSh/XiX8zx2SQTQHp3K/N7asXd4ddHiu+Mu
X-Gm-Gg: AZuq6aIJeKcRHaCAH0mAcsRFkvlZT697xpLRFthGNnSSzroR+cJxVMfPhWGRBBbMbdO
	1Im52Y6oq+QGN4yl93Zt2ZP5Cqw3ojsYs+vXEb0miAHb7Xqz6SdGciVGZYZ4yqXox8prQigtuBv
	rtErerI9TDmztkjaRE4w4q1WTVR++rlcmNeF4Oilaaz6ATJ/Ww+8SMf2j6ZSm5Hth08986aye6Q
	CPIEVLuwtLxNhgfKmERv6ByOkFgKBUqg3k8/tuLUEyLdwkHX7F5mqrckI1NCotkfWobq6poSUJp
	LbtfvkmRmtR5NSPtYqy2tVZqiqb6/BecV8PioN+vX8kmGkOE8PyJcP5DGEixVN4ZxVoLnv1zv21
	l2skXg1XhLUIQz1Su1eiYQeLFOt8Zbq3LSrvqZyPutePb8cNsntCS4llwE3l8n1GfLHP8N2ppIZ
	Nr8/QFygLVghr4EigmkDXVjtNfEV31FXQJk5Be8KDhSUg=
X-Received: by 2002:a05:600c:5295:b0:483:9139:4c29 with SMTP id 5b1f17b1804b1-48398a48450mr545325e9.2.1771365909130;
        Tue, 17 Feb 2026 14:05:09 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd259sm39593310f8f.24.2026.02.17.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:05:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:05:01 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 05/12] bpf: Add multi tracing attach types
Message-ID: <aZTmDU9nKhYsKEKd@krava>
References: <20260203093819.2105105-6-jolsa@kernel.org>
 <9df0acf7860b7e4a90b3e93e2d6924e9bad35fe307bef0bf9b50f8afb5cccacc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df0acf7860b7e4a90b3e93e2d6924e9bad35fe307bef0bf9b50f8afb5cccacc@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:13:53AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6b62b6d57..fb52ba2f7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -25069,7 +25074,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >  		return 0;
> >  	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
> >  		return bpf_iter_prog_supported(prog);
> > -	}
> > +	} else if (is_tracing_multi(prog->expected_attach_type))
> > +		return prog->type == BPF_PROG_TYPE_TRACING ? 0 : -EINVAL;
> 
> This isn't a bug, but should this branch have braces for consistency with the
> preceding branches in the same if/else chain? The BPF_TRACE_RAW_TP and
> BPF_TRACE_ITER branches both use braces.

right, will add it, thnx

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit message contains natural colloquial language and personal attribution typical of human kernel developers, and the code follows established BPF patterns with typical human oversights in style consistency.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor coding style inconsistency with missing braces in an else-if branch that does not affect functionality.

