Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55DD420472
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985220; cv=none; b=C3pYx1ky1zHywO0FUNDMZHCNq0wwMPz4vDrDJdVOazxqG7EsyOVqZ7DIuOedsDMQh0R3zMHdRdUL26669/V9FGSZfzs2RNc9xWUUsy5MW5W1l+4TArBm2D4M11IhZ5nv64rEGqSyaVU5+RfdtSkqTo30NiZJR4pgtw4IJZQB+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985220; c=relaxed/simple;
	bh=9jw50TickrTaZQXgt5lOY+a4WpEkiifrBIEHCEFDnmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFzDK2Tw9VbBxpO3f8uPSW6DrNSNG7czMtm87FSBwHmu/e4nDvDVIcXny9+uwxA+lxzX0+yD/My9iUqCw/5xGwNfSfrHOyEzRc0g/eqeuj+5FXBNCjDIDYpHlhegCfxMz1tumoamXf5l9A7eCSAE3LAxR61jBTnBAYYq2le7cRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NktLe6PE; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NktLe6PE"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66de7e0bc85so5682832d50.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788985213; x=1789590013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8UCfmj+BAmm+9KzmB0PX4qemdmhN7ZLk+S/oBX8ZU0=;
        b=NktLe6PEfo9VLJqPjt9OInn2zHhCM6DYzZwkX1imzBBVHl9Y2ZMtsE5ahTdRFsMiGE
         j9+PVsvNYl/Qpo8WY2lLohGaOGMLSBdnRxLTTBnWMok5ndj9zfMncKXxV84TmYgm8yVc
         qA4lOw9QdPhM+C8Az1zdB3l/FVgDKa5Ll0QJYhK5WydkPezmGEtNFEKUJ4RBei9DcbCf
         UJU3uuevT4Aa4VfmLjCT6UF2RlHVbG4wgACzUCOLOyA61GzrYvJLOPeVC5DYkUhoKkUy
         3mGSM7/AHmOKIUkywNguJuoVnq+wd8vo1ZIi5LDl35t8dldYLkX3/wCSqvbp0haLwh9L
         aSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788985213; x=1789590013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N8UCfmj+BAmm+9KzmB0PX4qemdmhN7ZLk+S/oBX8ZU0=;
        b=cNeY85QUsyoUvoFKf7QOTH5tzOxNZ/grryISAzLIzKVsHj7lwZysyujgKfgc9hh+B6
         RqGPNtof5vJH8XaADyD08xQ6ZMyoi6KygPhmdrUfMSLRaGXzt112EHiMcBwtuUQaniOb
         4TFDLLA/03qe2SLbv5pTAgZj44fQKxfpBb4NRLypKvWscEn4ADILTBNs6PwTdl4orI2G
         Is6X9s0grOfZC/o3kdUMOdm6yCccnYsMijlhwmvLWuGkHF6rHsDdjfomYem2oUnabnGp
         OEmIhkCzq8xh/W2I4SopeahvLBiQkB3ArcMt6obmP2R0WoaDQrQnFcky8mqnbVhkrwc9
         PFHw==
X-Gm-Message-State: AFuF++kyzwrraePm+7WOV4Qnb6jsirC6ut5ktphc5AZOv4NN0qQlrrI1
	DvTecGdNMmvPaXUwa+fDvip9f8bKTdYeUOhI1VCdfrLWwob3rEB/e4mr0/9uExVS
X-Gm-Gg: AYBFou2gsaSddqtIvTrzG9aLOQt8ECFo/F0pjI6JFYpOvZClZDUxtqtZWoxx8gptNVv
	QeW2xcmocp+swO6fJVhD7NWaoDYt+qWF+WQfym5eZlVIltP31UaF9q5xIGAW5ltwRaZ001DQcMH
	AdVa8Fr0hptUXugZsSGtqExqqvGPorghoCtR96cXnbdyPmlZBXIs6ym5Cz4Jqs/cI0tmll/pDrw
	AKVc4S5zI80wh7Rm9UcO+UojL0qaVKPSbcNP50DytQ7WDr8/PQgnQLtsW/ePDNfGmdu69d5jBrm
	D5aIopil+W7wSD2l8IPJxoK3Ky5ZwbkXYxThvfm8qFNZl5gP/Jq2/F7cRdVJHjpysbArUeQb+q1
	Q01TcKDHEa8fAu5xVgTw8yUApPDtQMie9KxmG5FgbZdA1vEUG84mj2ng80sYxR19Okj3jVjDqPS
	k+oRsu46dSaztna7EkiVrA5kTLRfbLHyrQ81wf1rjDLlQdk9ADL3YHK5s8QrgW7XF2W3KtgLzkZ
	DtB8fu6dDw+m5HtPpRamBltOWUPVZfp
X-Received: by 2002:a05:690c:e1e:b0:873:5ddf:d87a with SMTP id 00721157ae682-8735ddfdbd2mr117164447b3.69.1788985213338;
        Wed, 09 Sep 2026 13:20:13 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8821dd9932csm2117017b3.4.2026.09.09.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:20:13 -0700 (PDT)
Date: Wed, 9 Sep 2026 16:20:12 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 07/15] lsm: Add the bpf_lsm_policy_apply_bprm
 kfunc
Message-ID: <aqG7XUBqmUftjyyD@zenbox>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-8-utilityemal77@gmail.com>
 <20260909195500.DA3E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909195500.DA3E31F000FF@smtp.kernel.org>

On Wed, Sep 09, 2026 at 07:55:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The attach-point authorization boundary for `bpf_lsm_policy_apply_bprm` can be bypassed using BPF tail calls.
> --
> 
> commit 7b53e20161b20c35fb85beb1fba538fe85514074
> Author: Justin Suess <utilityemal77@gmail.com>
> Date:   Wed Sep 9 19:37:10 2026 +0000
> 
>     lsm: Add the bpf_lsm_policy_apply_bprm kfunc
>     
> This commit introduces the bpf_lsm_policy_apply_bprm kfunc, allowing sleepable
> LSM BPF programs to restrict credentials prepared in a linux_binprm. It
> restricts this kfunc to specific execution hooks (bprm_creds_for_exec and
> bprm_creds_from_file) to prevent policies from being applied at unsafe points.
> 
> > diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
> > index 43a4bf57fd31e..857e9a316d1cc 100644
> > --- a/security/bpf_lsm_kfuncs.c
> > +++ b/security/bpf_lsm_kfuncs.c
> 
> [ ... ]
> 
> > @@ -141,11 +202,18 @@ static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
> >  
> >  	switch (prog->type) {
> >  	case BPF_PROG_TYPE_SYSCALL:
> > +		if (kfunc_id == bpf_lsm_policy_apply_bprm_ids[0])
> > +			return -EACCES;
> >  		return 0;
> >  	case BPF_PROG_TYPE_LSM:
> >  		if (kfunc_id == bpf_lsm_policy_from_fd_ids[0])
> >  			return -EACCES;
> >  
> > +		if (kfunc_id == bpf_lsm_policy_apply_bprm_ids[0] &&
> > +		    !btf_id_set_contains(&bpf_lsm_policy_bprm_hooks,
> > +					 prog->aux->attach_btf_id))
> > +			return -EACCES;
> 
> [Severity: High]
> Can the attach-point authorization boundary be bypassed using BPF tail calls?
> 
> This verification-time check inspects the initial program's attach point,
> but does it account for runtime context switches via tail calls?
> 
> For example, if a privileged user loads Program A attached to
> bprm_creds_for_exec that calls bpf_lsm_policy_apply_bprm(), it passes this
> filter and can be inserted into a PROG_ARRAY map.
> 
> If they then load Program B attached to bprm_check_security and perform a
> bpf_tail_call() into Program A, the tail call is permitted because both
> hooks share identical BTF function prototypes (int (struct linux_binprm *)).
> 
> Does this allow bpf_lsm_policy_apply_bprm() to be executed at
> bprm_check_security, creating a TOCTOU vulnerability since the execution
> can still be rewritten by an interpreter?
>
Yes you can do this, but no it's not a vulnerability. No incorrect state
would be created here (in bprm_check_security, creds are still
uncommitted), so there's no issue in actually just letting a user apply
their policy there...

I'll probably just add bprm_check_security to the allowed hook list.
> > +
> >  		return 0;
> >  	default:
> >  		return -EACCES;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260909193719.518517-1-utilityemal77@gmail.com?part=7
