Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09054CF48
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083859; cv=none; b=LkAK+IS5fFxivG3ASbmdSTiEn5TMFjOz5d+46E3AspYuU1skTKmwGLj+mM/VMsn626nvIB/k2bPU6JvF2KeOHMCvJ1V6HOPf4Qyb6KiueYhxLLDjbdpnqCi1iW4gYmlZ0/j6SO5IFBwHv6sT/RR7tbAtQ2Zs1RqcZsUf71uqWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083859; c=relaxed/simple;
	bh=S6ponfKkIO6DnF4qJFjVrC8rAr0AKZgpLb3eM7dduYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLjM2UCgXwaq+sICbG81YG637DyHbLZSnu308Q56/z4jqScIVGv5Yzpe37RzjgyX/MjaXznpgLW8ntsLqv/YPQJ45ha4a3Hj2HAEI7cpkmGbZtbowrFuJXJ3KDUIBLhez2TaEmte6/bQhN8udwT/gswjv3jUvyBmz6QQIv7lFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aalx6uT3; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aalx6uT3"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a98604f6b4so5914351a12.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790083855; x=1790688655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwMwjaMgtqbI2n2Njr3tPSmtIkJudWhSYdevJ6ke0gw=;
        b=Aalx6uT3L1ZmD4Q8fd6nfFWHuBlHbASMp8puB2N2a7xWBKhhMgFjL79Ya2N+IYCvmf
         fOLqs8gIMMWZeMe12icflqW8Y9clVXsme2A0ZxYuLlTqU97JWjXdq7U19PZdsbdNJzD9
         7gOD3m79ZwNuHOQgwpA1PncNnEv4+4p/DM+PJGcd5bY/dCMJdB9gbOzTDexTdvAC8J5B
         ghviG0axaiF12dWDpy76qbnN3oi4miXvDQL1sZ2zEoQdWAgNGwLMzEPVyRbOvGgs5umA
         YNGVj1SlX33L+HmLQcXY6+bPyPGK08UhU1YUuCZxXJlaqZHeoZq4eGwjKsmpioZBJyoY
         MYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083855; x=1790688655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NwMwjaMgtqbI2n2Njr3tPSmtIkJudWhSYdevJ6ke0gw=;
        b=ppdqhgwOCXJUaIz6QA+FkoSuSp8t4K6kZPnbjNFRSpaGJPlIL/fr7zWTzZ2t7s23S0
         ZtUYWn7tadQOKrXo6m+nqIE1myziBMnz2xFGaBbDefS26nxe7Ox1myGWeo/JAEDnvQqk
         zQ7kQZpq1KqcPXiCE8+FayObpn4jYCxOpRqf06dTOK0p4oQgbwJVi3MOYZ0h1sKliz+u
         vm6ywhx516B6QWf2dp9saOdGNXbfwGfRokEUhbaHdZbd2LvMgj/jTe6e8fIpEQWumN/k
         Fhe5CKMv8H1F0Ju5rSl/WwLyPiEYdjk5wbrDaI1mdyoSEEEuax6jeWd7X8UdeIYvlaHi
         qxwg==
X-Forwarded-Encrypted: i=1; AKwUvBwIq3k6k9cKHzGjbJfKAkIi7BpHQkJJxr8KVxVR4lxGlY56Y2v5v7lv1dbzdGx6dOwcXEw=@vger.kernel.org
X-Gm-Message-State: AFuF++k4M+WB/poDIynSleke9E7Dzb85Um5Wg390nztPJjyMTV1HEbyo
	QsUhaGFDFFxlsoZ7evIhkhgGHqwxcpzmj/E9l0hOJ5i9IGtbA0ELfktXyILeJso2GS9M6jzKdsr
	JIOGFWbV+
X-Gm-Gg: AYBFou3rBtqiXQPCbL0xu0A+A5N1APqLVC0PINJoYn7pIW98//SDZEtDEOF8hWGZZ0w
	LC8NxtUGrqEuA+Kqn0aCU0m6eHZZI5YvWwwv0J90iXWADFzEelQ8JkztRc0ZDIiD/1MWruI3DB/
	eZ1YZxHsnpfG8rbmI/wSZnFG7IPlkoyCfj8FUSDoqEimkNoUjXzs0fGM0IHWviRXUnV0TLvqSc3
	KJFg5/3I0Ao172vlnoQDg7zxqG8vvmldPLe9vg0R4DoV4F7BDNc5L1YmbJ1HTTKYkMM7VLq7mTD
	7c4EUaungCEU+Ge8KcdgRpxu56nPrMXIQcUGMYxQzx8Z6Zo5yT1fopGj3WY+l07lU9FV0nxaJIT
	Dr1TvHEdtnRCueg5rT/i0XF0U5D+RjeDTmXWtu+gAy7/TUNGAJdLg9bjEYAtzI/Dzv3p2BbgAf8
	9aozEfsQD760CjYAq1LeE9R775rRXO/1p/k/GLKDXKzmraRG6mpUaQBFwdxEvAgOW6XQGoOCbTb
	P/e1FfwAon6/cseMo1GwIHZ4Pd4KA==
X-Received: by 2002:a05:6402:4382:b0:6a5:f4cd:ae39 with SMTP id 4fb4d7f45d1cf-6aa576eb334mr9923943a12.9.1790083854739;
        Tue, 22 Sep 2026 06:30:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:f7e6:6215:160f:a1f9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa44d13e2sm1048662a12.6.2026.09.22.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:30:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:30:49 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] landlock: Widen ruleset versions to 64 bits
Message-ID: <arKDCaXnG-T7To1n@google.com>
References: <20260922132615.1025945-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922132615.1025945-1-mic@digikod.net>

On Tue, Sep 22, 2026 at 03:26:14PM +0200, Mickaël Salaün wrote:
> Tracepoint consumers use a ruleset ID and version to identify the
> successful landlock_add_rule(2) call prefix used to create a domain.
> LANDLOCK_MAX_NUM_RULES bounds distinct stored rules, not successful
> calls: re-adding already-present rights for an object or port succeeds
> without increasing num_rules.  Because every successful call increments
> the version, these calls can wrap the 32-bit counter and give different
> prefixes the same trace identity.
> 
> Widen the counter and its trace fields to 64 bits so the counter cannot
> wrap in practice, while preserving the successful-call semantics.
> Saturating would alias all subsequent histories, while rejecting a call
> at the limit would change otherwise valid syscall behavior solely for
> trace metadata.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 63747c94774d ("landlock: Add landlock_add_rule_fs and landlock_add_rule_net tracepoints")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/trace/events/landlock.h | 20 ++++++++++----------
>  security/landlock/ruleset.h     |  5 +++--
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
> index 523ba5ea9870..3a43638c9bc2 100644
> --- a/include/trace/events/landlock.h
> +++ b/include/trace/events/landlock.h
> @@ -344,7 +344,7 @@ TRACE_EVENT(landlock_create_ruleset,
>  
>  	TP_STRUCT__entry(
>  		__field(	u64,		ruleset_id	)
> -		__field(	u32,		ruleset_version	)
> +		__field(	u64,		ruleset_version	)
>  		__field(	access_mask_t,	handled_fs	)
>  		__field(	access_mask_t,	handled_net	)
>  		__field(	access_mask_t,	scoped		)
> @@ -358,7 +358,7 @@ TRACE_EVENT(landlock_create_ruleset,
>  		__entry->scoped		= ruleset->handled_masks.scope;
>  	),
>  
> -	TP_printk("ruleset=%llx.%u handled_fs=%s handled_net=%s scoped=%s",
> +	TP_printk("ruleset=%llx.%llu handled_fs=%s handled_net=%s scoped=%s",
>  		__entry->ruleset_id, __entry->ruleset_version,
>  		__print_flags(__entry->handled_fs, "|", _LANDLOCK_ACCESS_FS_NAMES),
>  		__print_flags(__entry->handled_net, "|", _LANDLOCK_ACCESS_NET_NAMES),
> @@ -384,7 +384,7 @@ TRACE_EVENT(landlock_free_ruleset,
>  
>  	TP_STRUCT__entry(
>  		__field(	u64,		ruleset_id	)
> -		__field(	u32,		ruleset_version	)
> +		__field(	u64,		ruleset_version	)
>  	),
>  
>  	TP_fast_assign(
> @@ -392,7 +392,7 @@ TRACE_EVENT(landlock_free_ruleset,
>  		__entry->ruleset_version = ruleset->version;
>  	),
>  
> -	TP_printk("ruleset=%llx.%u",
> +	TP_printk("ruleset=%llx.%llu",
>  		__entry->ruleset_id, __entry->ruleset_version)
>  );
>  
> @@ -423,7 +423,7 @@ TRACE_EVENT(landlock_add_rule_path_beneath,
>  
>  	TP_STRUCT__entry(
>  		__field(	u64,		ruleset_id	)
> -		__field(	u32,		ruleset_version	)
> +		__field(	u64,		ruleset_version	)
>  		__field(	access_mask_t,	access_rights	)
>  		__field(	dev_t,		dev		)
>  		__field(	ino_t,		ino		)
> @@ -444,7 +444,7 @@ TRACE_EVENT(landlock_add_rule_path_beneath,
>  		__assign_str(pathname);
>  	),
>  
> -	TP_printk("ruleset=%llx.%u access_rights=%s dev=%u:%u ino=%lu path=%s",
> +	TP_printk("ruleset=%llx.%llu access_rights=%s dev=%u:%u ino=%lu path=%s",
>  		__entry->ruleset_id, __entry->ruleset_version,
>  		__print_flags(__entry->access_rights, "|", _LANDLOCK_ACCESS_FS_NAMES),
>  		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino,
> @@ -477,7 +477,7 @@ TRACE_EVENT(landlock_add_rule_net_port,
>  
>  	TP_STRUCT__entry(
>  		__field(	u64,		ruleset_id	)
> -		__field(	u32,		ruleset_version	)
> +		__field(	u64,		ruleset_version	)
>  		__field(	access_mask_t,	access_rights	)
>  		__field(	u64,		port		)
>  	),
> @@ -490,7 +490,7 @@ TRACE_EVENT(landlock_add_rule_net_port,
>  		__entry->port		= port;
>  	),
>  
> -	TP_printk("ruleset=%llx.%u access_rights=%s port=%llu",
> +	TP_printk("ruleset=%llx.%llu access_rights=%s port=%llu",
>  		__entry->ruleset_id, __entry->ruleset_version,
>  		__print_flags(__entry->access_rights, "|", _LANDLOCK_ACCESS_NET_NAMES),
>  		__entry->port)
> @@ -526,7 +526,7 @@ TRACE_EVENT(landlock_create_domain,
>  		__field(	u64,		domain_id	)
>  		__field(	u64,		parent_id	)
>  		__field(	u64,		ruleset_id	)
> -		__field(	u32,		ruleset_version	)
> +		__field(	u64,		ruleset_version	)
>  	),
>  
>  	TP_fast_assign(
> @@ -538,7 +538,7 @@ TRACE_EVENT(landlock_create_domain,
>  		__entry->ruleset_version = ruleset->version;
>  	),
>  
> -	TP_printk("domain=%llx parent=%llx ruleset=%llx.%u",
> +	TP_printk("domain=%llx parent=%llx ruleset=%llx.%llu",
>  		__entry->domain_id, __entry->parent_id,
>  		__entry->ruleset_id, __entry->ruleset_version)
>  );
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index b536fa0425b7..cf77f1806a95 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -171,9 +171,10 @@ struct landlock_ruleset {
>  	 * @version: Counter incremented on each successful
>  	 * landlock_add_rule(2), including when it only extends an existing
>  	 * rule's access rights.  Used by tracepoints to correlate a domain with
> -	 * the exact ruleset state it was created from.  Protected by @lock.
> +	 * the exact successful rule history it was created from.  Protected by
> +	 * @lock.
>  	 */
> -	u32 version;
> +	u64 version;
>  	/**
>  	 * @id: Unique identifier for this ruleset, used for tracing.
>  	 */
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Looks correct.  Good to get this in before 7.3 is finalized.

—Günther
