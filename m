Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931D30C62D
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772695011; cv=none; b=Q9F1E7i+LrD1s9hK1DmbYdOcTxMKjuWm7BvxwxqZXA75AR+3WM/CJfVmiojkPtpVn7Fa6VRPGPR6JsaOLvwLE8yPV/OfBDnbHhQ9jWBNWEYx6SDjCP+gSM7KZhsug3lFxk5D5dR0Jywvln3LA8xpbOez1YMrAXc8132VXamVP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772695011; c=relaxed/simple;
	bh=3l6xAzbLtTmepWBb4mTwXWx2jqG1Qzvd3VQpoDc/+3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZcI3apS50Tq0iGUVnfev7ZFssEbICCaB+kZCQ2O4bFhdviNGb3n7DO5ATy9JQGqrSWiNOD3Vs/F0pCXZ8mCnmzcwc4QwKgG6c3c/MyROKXIvIZzhznT35YiGncv+Z1ARrgvvsV24tpEEORMJMuF3oEH55fHtYfowUmUmQLTRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqOro29C; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqOro29C"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48378136adcso45716575e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 23:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772695009; x=1773299809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5DTydL42chhunqhrPV2dhB9V973kmBV2P3Jq0tj1g4=;
        b=ZqOro29CXB6a7cYwpT7YNh77et9IyvuTRsMU87cJSWcBDrveKP7kaGbB1LMFnfDh6v
         TKDtVB9V+vPbueMye6izeFU0Junwxtp+mLb+KQc6p+qFfTAeih0XRcLRslnMHSXlBirJ
         61WaO/PyU5lazXmeowXWWroSsUBJnXaIS3Oa1AZDbycDUmxatwI8HcrK3a0RUXFDK1QH
         aM1/aCllKWNA4zHmN80lHnvb8IN/BDLrzyv5bbp3qchyrya8ClSdsDm922s7iFju65wU
         ckKYAoVodvaNDG8hSDWyV2o2TwKAK/icUnNzECqlSbrEo1YspTercuvMdw16TiiV4HKk
         gElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772695009; x=1773299809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5DTydL42chhunqhrPV2dhB9V973kmBV2P3Jq0tj1g4=;
        b=Tz0LIDLSVsFNmN+9VKiVByupmdKzhq446V+ugwXit9+9losRYygaNsFRQWJE+6m1q8
         KXntm/zqS7uTkjex/gzl5pGK6FMb2oswILFU88Rb2gjCGY+t8gi0sTZKpbxcaFBqLBpN
         DtsLZL2oVSLdSzFgHqIRhycEyrEGn9FXhKJmGRd/GHTVLQpQnG1Lko0tgefNxa/4qgzD
         Lz2L1LchCAd5TMsNDG6GO3TC3XzjshCVRVUqBCQE9ZkzdJgb2ev6B/LrCYAUFvoPB4Dw
         hL+ud/0+cpSRgf3wMCidIzGZvnPRjaoCphaaFvdU9HkjMjdzbybDNeed8C+w+l6DYxl8
         NO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkPkaRMRdMkGLS7DbQXHBbHgPeZ299mPMBkyAzRbWT4JPr1VskeiNXeJJK/1PDWKHLVvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLPrbYqXCfVeAgYiCV4JGeGdkCK/Hb39shxV419fZlBvajSFM
	tbzE19hKBcQ2ryqt3+E7dfAg6ahd19TE1SAnl0klAq8qpjl880tdhvzJ
X-Gm-Gg: ATEYQzzwDk9SHEXmTt32fRbdELa575wuvf+yXz/S9UE1sCwJUzfPe/Hz3kWQQV9hz7y
	PNPIvMtWoB/vejSIW9kCpzSKW/HyxLp1JDZrKzhQ6FSlMGNm8aIJLA77HnOMxIkf3LufeMYM7Iz
	9IGdSjfjxeEUBGMHfug0EB0DSDp5XD8wh8HC72N+xmQlGMXujHZZd0++FIvtReobZtWkz7LgS5g
	QgdGhenyAUuRCz5tmEXJyVds086aBxhdceYUqLPI3Xgq4K9As4NVWMv0M+Rjt/T3ADDKEyUy+Cf
	OTuKveaFD5llT+jgRZimxkdfAHDxVSYV9q0UO2kTkOvoyQVSx5Z3Zxbp85fx76juJ7NSMNj+feq
	xUrSZfjkiIAAvnr6bT7A85Zb1ph45j5o0E5OcQP1sMuZAleQf8xbmY/3EijMdJ6ObH1zpInANqm
	/wLQOTUn9NPPvwUKR7fyni4Q3m9gPBpRX6XGvo8sFUjLYGfGrJ2w==
X-Received: by 2002:a05:600c:a08c:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-485198bac26mr85292725e9.35.1772695008566;
        Wed, 04 Mar 2026 23:16:48 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae475csm20714535e9.8.2026.03.04.23.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:16:48 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: jrife@google.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com,
	wangqing7171@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2] bpf: Fix use-after-free in __bpf_trace_run()
Date: Thu,  5 Mar 2026 15:16:36 +0800
Message-Id: <20260305071636.1174156-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xt2wdltgcksndmsizbzhyedshr4qaadmn6pgto76x4kiv7kczh@cobpljlcjttp>
References: <xt2wdltgcksndmsizbzhyedshr4qaadmn6pgto76x4kiv7kczh@cobpljlcjttp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 05 Mar 2026 at 09:38, Jordan Rife <jrife@google.com> wrote:
> > A use-after-free issue reported from syzbot exists in __bpf_trace_run().
> > 
> > BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
> >     -> struct bpf_prog *prog = link->link.prog;
> > 
> > The link(struct bpf_raw_tp_link) was freed before accessing
> > link->link.prog.
> > 
> > The root cause is that: When bpf_probe_unregister() is called, tasks may
> > have already entered the old tp_probes array (RCU read-side section)
> > before rcu_assign_pointer() updates tp->funcs. These tasks can access the
> > link through the old array. Without synchronization, the link can be freed
> > via call_rcu() after bpf_probe_unregister() in bpf_link_free(), leading to
> > use-after-free in __bpf_trace_run().
> > 
> > CPU 0 (free link)                    CPU 1 (enter old tp probe)
> > ─────────────────                    ────────────────────────
> > 
> >                                      rcu_read_lock()
> >                                      old_funcs = tp->funcs
> > bpf_raw_tp_link_release()
> > bpf_probe_unregister()
> > rcu_assign_pointer(tp->funcs, new)
> > call_srcu/call_rcu_tasks_trace(old_tp)
> > ...
> > call_rcu/call_rcu_tasks_trace(&link->rcu, ...)
> 
> If CPU 1 is in an RCU read-side section, then call_rcu would wait for
> the RCU GP anyway before freeing the link in question.

Sry, It's my mistake that it should be 'srcu_read_lock(&tracepoint_srcu)'[0]
but not rcu_read_lock(), so that misleaded you. It only wait for the srcu
grace period (tracepoint).

    [0]
    include/linux/tracepoint.h:279
    #define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
    	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
    	static inline void __do_trace_##name(proto)			\
    	{								\
    		TRACEPOINT_CHECK(name)					\
    		if (cond) {						\
    			guard(srcu_fast_notrace)(&tracepoint_srcu);	\   <----
    			__DO_TRACE_CALL(name, TP_ARGS(args));		\
    		}							\
        }


> > (RCU grace period)
> > kfree(link)
> >                                      __bpf_trace_run(link, ...)
> >                                      access link->link.prog
> >                                      UAF!
> > 
> > Fix by calling tracepoint_synchronize_unregister() to ensure all
> > in-flight tracepoint callbacks have completed, so the link is no
> > longer reachable before it is freed.
> 
> It looks like tracepoint_synchronize_unregister() just calls
> synchronize_rcu_tasks_trace() and synchronize_rcu(), but it should also
> be sufficient to use call_rcu() or call_rcu_tasks_trace() to ensure that
> the appopriate grace period elapses for that tracepoint. Is the extra
> delay just masking the problem instead of fixing the root cause?

I think using synchronize_srcu(&tracepoint_srcu) is enough to ensure those
used old tp_probes can exit srcu_read_lock() before kfree(link). It needs
further discussion whether to use tracepoint_synchronize_unregister().

> > The issue was introduced by commit d4dfc5700e86 ("bpf:
> > pass whole link instead of prog when triggering raw tracepoint"),
> > which changed tracepoint callbacks to receive bpf_raw_tp_link pointers
> > instead of bpf_prog pointers.
> 
> Did you run a bisect?

I'm trying to run it, but I haven't reproduced it yet.

--
Qing
