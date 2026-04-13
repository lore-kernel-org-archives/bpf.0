Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879735A925
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092778; cv=none; b=Jig1reET1LLlDD8vCgr3cMuMxBG+LjXR4x8P3okqIEiXmAc12AV0OzeFuolEDaQ5KManD66rrvK348V/aM2wvdIv2XHj2zLG40iaoHvFcq8e8SE5BUevauzxsccYf9ii6hfqEDOJgDAD26k/8CqTHEcwiwZ13mb3s1FTMObi5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092778; c=relaxed/simple;
	bh=Emi4rcorWs96xqit3QSlCkSRrjzsDn+QyDkgEkTPR3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMyvzZMI5wlPztl2TME/CfTcZv6ZPWB/17TWtmL3VYDeicdE7y+lvjItkPzGLVEC0EGkp6Piw1YBnYw1FGwyQqECdw932NH7yFrIEhEgoaVNSRAaRRvX/EBs1QMRMvletm0IL+8qeEVEWZWPIdrJWoF/WoPAa5KKzW4P8bPjLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwJlYZGz; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwJlYZGz"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651b4d09141so2297061d50.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776092774; x=1776697574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vifko5KmbSbCk8BOACbo4hqllxNpnjRhw8JsSNxqa58=;
        b=ZwJlYZGzrXqyJeQQbHTQoVfxB7L1bg5Ddq9lAXyaR6s94QBid6Y5fioqbh0Uckz/i8
         G/h/ZyiXJpmq+aldvXvt05fLyfqFPQAAP2mOzvsA0Zy6aHBURATqK7de3w7JvbYjt6N8
         bO5Ugh4NHEprK+rnKKpDMfMWsYdaiCpgaW8ePBwGpPE5GzQxuhNCcMy5yfzMeGPexwlY
         breoXDz9XnqWZsCrRy/Fw2kGVZw7zOhcjFHSa/uEDKUd68WoCLhnFDembYo8S61j+AZS
         94/YfAqqrUdlFHwPC2hxkFLz+9eWwjpXn2RnzKZQuuotbfF9xNNiw8t5a49Rj0wuYJlU
         l0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776092774; x=1776697574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vifko5KmbSbCk8BOACbo4hqllxNpnjRhw8JsSNxqa58=;
        b=UGnrg8gJMExKwMGTPjX0G2qfd2Qq+SlF4gtV2IRYYW/7enkmyK84atjJuobYWXHtFa
         Je/qz2KfgOuUOIZ/nlLwmtN5nD5z7LO+trGtUw13/fF0i4ozM7o63jbN+GhS54qyvE1d
         dU64phDmC/vLrH28EQs5QgbdRmrORCm/NDlPa80dJ3roUpxJCBscSbWTtnAxkAL9LnSQ
         W1DmFVPIZCt2/0pLibrgNm3YGlfjXTpPJPIXLr0qSJXzaQB/+iVBDE6XkVKwvbu5Pst4
         RzHRPP3e4rTg7bR7/3yP9Nr+6N83yHVVJu/Sh3UlMin62bEur/KisZiMzHXlXOnjIWPb
         FPcg==
X-Forwarded-Encrypted: i=1; AFNElJ9Kbx73MUfmrSeEo07zYIwsWG2E0HmSaG3RHKecmJW1D+KpwzsPGh/jJK53+JFIjcxN6YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjeAri+Q17ptXAdxCD4GGU+doc7ww8HgBxRFQ7GFi3DjrYG5J
	2T9wMPjj/ZsQTk1vz+NWxlIVvRFojRIeFQVQG2xLS4O5bbvM8iZYYhvq
X-Gm-Gg: AeBDieuptQqSBiPCyn3wRp7p+gqZ390QE165VQD+jTRiyzw3UgqEn0zAsfLrNp3dFSd
	UQjPUOgH8lfg3optFBIEpjcOWgwOV5kaJCIdYray7vokGwkYPwsl3RWw35xNRyoTG0+LnDu4Gzi
	jxmBK3TWhdt5bjtUjWs7jNt2EOLUyaHdmNV1ofHTEZ5RLcsoUsrWUgYoIICFjGX+T/Hca2ULAv9
	/z8eOgJ17xjv1bvPyNpivTs8pb/bCAtp28G4hrDJ3dZg2BxRqyNh4qMe72uOb2gnHXRbwMj/h13
	YporEZkyCO7ByHnK6Jfs1wDxtHoXT8vGYw/6+gk+B2NdTe/B1gwCBW1hIO7aF1ygYujGvBlXlpJ
	CUqgTeoStp3LGAjcBcBAela/HOcKUBmSfxDVdDL7pwkRAKmAF9H6Fvp0C1E/0swplpcP/do62XR
	GpQWITDArlMK1eDjPbFcXOvi563BV3y3fV2zZqAZrXPKwsnP6Vmr4R6UM5ZMvNguiYQD6LGBXdB
	ic=
X-Received: by 2002:a05:690e:1289:b0:651:db4c:808f with SMTP id 956f58d0204a3-651db4c9b26mr819151d50.45.1776092774024;
        Mon, 13 Apr 2026 08:06:14 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:210a:5ead:460c:3a36])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65197a3d41bsm5358631d50.1.2026.04.13.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:06:13 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:06:11 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	brauner@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	fred@cloudflare.com, gnoack@google.com, jack@suse.cz,
	jmorris@namei.org, john.fastabend@gmail.com, kees@kernel.org,
	kpsingh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	m@maowtm.org, martin.lau@linux.dev, paul@paul-moore.com
Subject: Re: [RFC PATCH 00/20] BPF interface for applying Landlock rulesets
Message-ID: <ad0GYw198O97pabw@suesslenovo>
References: <20260408.ong9Eshe0omu@digikod.net>
 <20260408171030.4083129-1-utilityemal77@gmail.com>
 <20260408.ainu5Chohnge@digikod.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408.ainu5Chohnge@digikod.net>

On Wed, Apr 08, 2026 at 09:21:11PM +0200, Mickaël Salaün wrote:
> On Wed, Apr 08, 2026 at 01:10:28PM -0400, Justin Suess wrote:
> > 
> > Add a flag LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS, which executes
> > task_set_no_new_privs on the current credentials, but only if
> > the process lacks the CAP_SYS_ADMIN capability.
> > 
> > While this operation is redundant for code running from userspace
> > (indeed callers may achieve the same logic by calling
> > prctl w/ PR_SET_NO_NEW_PRIVS), this flag enables callers without access
> > to the syscall abi (defined in subsequent patches) to restrict processes
> > from gaining additional capabilities. This is important to ensure that
> > consumers can meet the task_no_new_privs || CAP_SYS_ADMIN invariant
> > enforced by Landlock without having syscall access.
> > 
> > This is done by hooking bprm_committing_creds along with a
> > landlock_cred_security flag to indicate that the next execution should
> > task_set_no_new_privs if the process doesn't possess CAP_SYS_ADMIN. This
> > is done to ensure that task_set_no_new_privs is being done past the
> > point of no return.
> > 
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> > 
> > On Wed, Apr 08, 2026 at 02:00:00 -0000, Mickaël Salaün wrote:
> > > > Points of Feedback
> > > > ===
> > > > 
> > > > First, the new set_nnp_on_point_of_no_return field in struct linux_binprm.
> > > > This field was needed to request that task_set_no_new_privs be set during an
> > > > execution, but only after the execution has proceeded beyond the point of no
> > > > return. I couldn't find a way to express this semantic without adding a new
> > > > bitfield to struct linux_binprm and a conditional in fs/exec.c. Please see
> > > > patch 2.
> > 
> > > What about using security_bprm_committing_creds()?
> > 
> > Good idea. Definitely cleaner.
> > 
> > Something like this? Then dropping the "execve: Add set_nnp_on_point_of_no_return"
> > commit.
> > 
> > This adds a bitfield to the landlock_cred_security struct to indicate that the flag
> > should be set on the next exec(s).
> > 
> >  include/uapi/linux/landlock.h | 14 ++++++++++++++
> >  security/landlock/cred.c      | 13 +++++++++++++
> >  security/landlock/cred.h      |  7 +++++++
> >  security/landlock/limits.h    |  2 +-
> >  security/landlock/ruleset.c   | 15 ++++++++++++---
> >  security/landlock/syscalls.c  |  5 +++++
> >  6 files changed, 52 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index f88fa1f68b77..edd9d9a7f60e 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -129,12 +129,26 @@ struct landlock_ruleset_attr {
> >   *
> >   *     If the calling thread is running with no_new_privs, this operation
> >   *     enables no_new_privs on the sibling threads as well.
> > + *
> > + * %LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
> > + *    Sets no_new_privs on the calling thread before applying the Landlock domain.
> > + *    This flag is useful for convenience as well as for applying a ruleset from
> > + *    an outside context (e.g BPF). This flag only has an effect on when both
> > + *    no_new_privs isn't already set and the caller doesn't possess CAP_SYS_ADMIN.
> > + *
> > + *    This flag has slightly different behavior when used from BPF. Instead of
> > + *    setting no_new_privs on the current task, it sets a flag on the bprm so that
> > + *    no_new_privs is set on the task at exec point-of-no-return. This guarantees
> > + *    that the current execution is unaffected, and may escalate as usual until the
> > + *    next exec, but the resulting task cannot gain more privileges through later
> > + *    exec transitions.
> >   */
> >  /* clang-format off */
> >  #define LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF		(1U << 0)
> >  #define LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON			(1U << 1)
> >  #define LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF		(1U << 2)
> >  #define LANDLOCK_RESTRICT_SELF_TSYNC				(1U << 3)
> > +#define LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS			(1U << 4)
> >  /* clang-format on */
> >  
> >  /**
> > diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> > index 0cb3edde4d18..bcc9b716916f 100644
> > --- a/security/landlock/cred.c
> > +++ b/security/landlock/cred.c
> > @@ -43,6 +43,18 @@ static void hook_cred_free(struct cred *const cred)
> >  		landlock_put_ruleset_deferred(dom);
> >  }
> >  
> > +static void hook_bprm_committing_creds(const struct linux_binprm *bprm)
> > +{
> > +	struct landlock_cred_security *const llcred = landlock_cred(bprm->cred);
> > +
> > +	if (llcred->set_nnp_on_committing_creds &&
> > +	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN)) {
> 
> If asked by the caller, NNP must be set, whatever the capabilities of
> the task.
> 
> > +		task_set_no_new_privs(current);
> > +		/* Don't need to set it again for subsequent execution. */
> > +		llcred->set_nnp_on_committing_creds = false;
> > +	}
> 
> Thinking more about it, it would make more sense to add another flag to
> enforce restriction on the next exec.  This new cred bit would then be
> generic and enforce both NNP (if set) and the domain once we know the
> execution is ok.  That should also bring the required plumbing to
> create the domain at syscall (or kfunc) time and handle memory
> allocation issue there, but only enforce it at exec time with
> security_bprm_committing_creds() (without any possible error).
>

I did some more consideration as well over the weekend.

For no new privs post point of new return:

It still seems to me we can't have post point-of-no-return setting of
NNP from userspace without CAP_SYS_ADMIN for the security reason
listed previously. The BPF side may not need to be subject to that
restriction, since it's in a higher security boundary.

For ruleset enforcement post point of no return:

The post point-of-no-return enforcement of a ruleset from
userspace would be OK, as long as the existing task_no_new_privs ||
CAP_SYS_ADMIN invarient is enforced.

The way I'm thinking of implementing this is storing two pointers to
unmerged rulesets in struct landlock_cred_security. One for the BPF side
and one for the userspace side. If landlock_restrict_self is called with
LANDLOCK_RESTRICT_SELF_EXECTIME (proposed name for this flag), then the
domain would be copied and the pointer to the copy and stored there.

The BPF side would have a seperate pointer, and do the same copy and
store.

Repeated calls to landlock_restrict_self LANDLOCK_RESTRICT_SELF_EXECTIME
would put the reference (and hence free) on the stored unmerged domain,
then store the new one.

When we reach the security_bprm_committing_creds hook, we can merge the
domains in a deterministic order:

1. Existing domain (if any)
2. The domain stored from bpf_landlock_restrict_bprm (if any)
3. The domain stored from landlock_restrict_self w/
LANDLOCK_RESTRICT_SELF_EXECTIME (if any)

Then set the domain pointer to the newly merged domain.

Then we release the references on the stored domains and reset the
pointers to null.

Some implementation details:

1. LANDLOCK_RESTRICT_SELF_EXECTIME w/ bpf_landlock_restrict_binprm is
   redundant since the kfunc is designed to apply there anyway so we can return an error
   if it is explictly set when used with that kfunc. (Or always require
   it be set)
2. The existing LANDLOCK_RESTRICT_SELF_LOG_* flags would be set on the
   stored domain.
3. The TSYNC flags would be sort of misleading for either of these two
   flags and should be mutually exclusive with both of the NO_NEW_PRIVS
   and EXECTIME flags.
4. Common enforcement and merge path for bpf and userspace as you stated
   earlier 

I can make a separate series with one or both of these flags if you
wish once we hear about the preferred tree that this needs to be based
on. Or keep it as one (very large) series.

Justin

> > [...]
