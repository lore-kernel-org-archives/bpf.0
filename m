Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023235F5FD
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574488; cv=none; b=lU04zfwfvkU0AwFaII9BGrEKe8lj1i7+/s8xPe23CLad2qZT2Tc/o8tm89ot7YIylGauiBrIQYsJx3e6h0sOGvIXjDpbxRRrZNOno1PYWGpoAcc+KqveSfvSSnYZL17gllW+sToLK+lH725EKvZe0QdeVuj8TyJv4JfTT5OOtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574488; c=relaxed/simple;
	bh=ty0KOjKQyTnZaKdoshASSXSZqQBi5bCYN1Ysfs56ZTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7moHkB4Fmkg5l0NnsLhitPLc9IPO9KwY/zeidWXfdedq0O8s+Uo23uRrW241HbkUE+eCdVgHGl57Row4sY5QiHwRaWoelT4ecvBhlNN92mREwQ2m+izrs9144j6WvjtBv3iRifKyjxLkEVrkZiXG5wMSkb1kIlYJaeGaRtWN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fdh61hJ2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fdh61hJ2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso47720975e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775574485; x=1776179285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iGjzV8IRrkdKa9tu7b5Wnqj/M+3GwqIJMX4TAs0mafs=;
        b=Fdh61hJ2egMuHDvAbE6gAEG/65sTZblgScVS+1N3Vj1HG+HKR43vGkI0SxB6dluWUn
         onOkN9rBRgcJ9rtrNZijPd0J19K4tq4AU9Q9ZqTQHWaw4ZvLTGUIaawaWSmzHKF1emy+
         N947KqfTVR1hijj1VCrVR6wrLIhVNr6MUmUD+7EPTpCv7eSEskkIFRo1shKkZkTuNCzD
         wdrqhes8jYnbjdBPzU1ryaGArly3DhzaQbWX9Q5IrvkW61ZJQAHL1RhTZkWITIV8nwEb
         DuhMeFtjHXFc+FqRGPjhR8r4LbRXvwMQHHcCZyEEyQjyfRv1fgrB9B7PHNXHYqo6Gem6
         ZJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574485; x=1776179285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGjzV8IRrkdKa9tu7b5Wnqj/M+3GwqIJMX4TAs0mafs=;
        b=NCufgMciTRidhdoqPPQ8GCiH7pjh9nqLvDs5fRl8RCT/rXRE0HMuvHu3dEZJ85mUsB
         ucofO1H2FK/Cs4BfCVON8zzEiva6WK2ZCbi2/as5P63BfqgGonYgpgr1RmUw4OP8UPI7
         nV37HHoiJkdNgsyDpkYHiE1qeBEQuUt2ga4hSH7tUTKdHiilcQhhP9OezuQi0J92Oaq+
         1E0HcIdRK4QHFvM48heKIzVolfJ3EKHl6BWTYQ7W6ng5k0OceNFAAceRhMZ832UmcIG6
         8/Wobs6V/tv1bqvwxYKw6m9p2jq/X+bPw1AffO8OCM70WsDTmKXcTHraJG8zFNHkSZZo
         iz5g==
X-Forwarded-Encrypted: i=1; AJvYcCU5uI4+v1YH3UPrsokoqtWV5Yk9+rWXH/0VBXWTZwPrNlHqbs46LlfUCAqgjlcRs9F7Jds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVE+Zsu7BQFenLuBIwwvJIja5A9eFkenBSnCBA86KtvhzrS0bi
	4x6y4W7BJ1QmIbYxduP7knRiSJWUFa4ZnbyzD4FtZ5XU50Y9pw+IlD4YoKncNPCnP64=
X-Gm-Gg: AeBDietm0+mVeVPsaIM1Qtc0Nx4eZ83TsmyX35mhKRz1kMLY8tW5/5GKz4MXv6YmsWe
	Lzr2C+S1ZC9qQhhox1IvMgt9MMv/s8g8M7uibE2rHgaSGWmrGP6IkP2zG8I3AJ4q+oYdTWAeUy6
	MggI+GNXD322h4+KnGwC9xmGhWzh7Ir/ae6A+EX8ZkrFuimmGxH+gq3va7/oqsSF3rlNZDqCl1G
	fvZ814TajhaThGhJmpGIhGJmqlMH7xTSTeEHAcXbxL4rWEb5eMGznuf80KZffaE8/GsOXP4XVrD
	26IxximdheTkPp8gZ6Zn7K8NP87ZBtEdp3TIFKiYfziYcZSDrB31QGM5Rer4JPHOwpdyFEmWSlc
	KovUVyluDk4m+5V1dXe5+EVxqYhptyyaxFqjZLyNN1X4jZDklZRHO9aAvFlFiURBN/DjTDArxfn
	QtTOjirnGnyPKOf94OaXR1/Ix/6p+hCUUPctnoIejY7MdhHLlBakA=
X-Received: by 2002:a05:600c:138f:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4889970e3c4mr239821275e9.11.1775574484681;
        Tue, 07 Apr 2026 08:08:04 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm555642275e9.14.2026.04.07.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:08:03 -0700 (PDT)
Date: Tue, 7 Apr 2026 17:08:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org, mattbobrowski@google.com, jolsa@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	yonghong.song@linux.dev, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to
 klp_patch
Message-ID: <adUd0Mojbtrwmeod@pathway.suse.cz>
References: <20260402092607.96430-4-laoar.shao@gmail.com>
 <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
 <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com>
 <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>

On Tue 2026-04-07 17:45:31, Yafang Shao wrote:
> On Tue, Apr 7, 2026 at 11:16 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Tue, Apr 7, 2026 at 10:54 AM Song Liu <song@kernel.org> wrote:
> > >
> > > On Mon, Apr 6, 2026 at 2:12 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> > > [...]
> > > > > > > - The regular livepatches are cumulative, have the replace flag; and
> > > > > > >   are replaceable.
> > > > > > > - The occasional "off-band" livepatches do not have the replace flag,
> > > > > > >   and are not replaceable.
> > > > > > >
> > > > > > > With this setup, for systems with off-band livepatches loaded, we can
> > > > > > > still release a cumulative livepatch to replace the previous cumulative
> > > > > > > livepatch. Is this the expected use case?
> > > > > >
> > > > > > That matches our expected use case.
> > > > >
> > > > > If we really want to serve use cases like this, I think we can introduce
> > > > > some replace tag concept: Each livepatch will have a tag, u32 number.
> > > > > Newly loaded livepatch will only replace existing livepatch with the
> > > > > same tag. We can even reuse the existing "bool replace" in klp_patch,
> > > > > and make it u32: replace=0 means no replace; replace > 0 are the
> > > > > replace tag.
> > > > >
> > > > > For current users of cumulative patches, all the livepatch will have the
> > > > > same tag, say 1. For your use case, you can assign each user a
> > > > > unique tag. Then all these users can do atomic upgrades of their
> > > > > own livepatches.
> > > > >
> > > > > We may also need to check whether two livepatches of different tags
> > > > > touch the same kernel function. When that happens, the later
> > > > > livepatch should fail to load.

I still think how to make the hybrid mode more secure:

    + The isolated sets of livepatched functions look like a good rule.
    + What about isolating the shadow variables/states as well?

> > That sounds like a viable solution. I'll look into it and see how we
> > can implement it.
> 
> Does the following change look good to you ?
> 
> Subject: [PATCH] livepatch: Support scoped atomic replace using replace tags
> 
> Extend the replace attribute from a boolean to a u32 to act as a replace
> tag. This introduces the following semantics:
> 
>   replace = 0: Atomic replace is disabled. However, this patch remains
>                eligible to be superseded by others.
>   replace > 0: Enables tagged replace (default is 1). A newly loaded
>                livepatch will only replace existing patches that share the
>                same tag.
> 
> To maintain backward compatibility, a patch with replace == 0 does not
> trigger an outgoing atomic replace, but remains eligible to be superseded
> by any incoming patch with a valid replace tag.
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index ba9e3988c07c..417c67a17b99 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -123,7 +123,11 @@ struct klp_state {
>   * @mod:       reference to the live patch module
>   * @objs:      object entries for kernel objects to be patched
>   * @states:    system states that can get modified
> - * @replace:   replace all actively used patches
> + * @replace:   replace tag:
> + *             = 0: Atomic replace is disabled; however, this patch remains
> + *                  eligible to be superseded by others.

This is weird semantic. Which livepatch tag would be allowed to
supersede it, please?

Do we still need this category?

> + *             > 0: Atomic replace is enabled. Only existing patches with a
> + *                  matching replace tag will be superseded.
>   * @list:      list node for global list of actively used patches
>   * @kobj:      kobject for sysfs resources
>   * @obj_list:  dynamic list of the object entries
> @@ -137,7 +141,7 @@ struct klp_patch {
>         struct module *mod;
>         struct klp_object *objs;
>         struct klp_state *states;
> -       bool replace;
> +       unsigned int replace;

This already breaks the backward compatibility by changing the type
and semantic of this field. I would also change the name to better
match the new semantic. What about using:


  * @replace_set: Livepatch using the same @replace_set will get
		atomically replaced, see also conflicts[*].

	unsigned int replace_set;

[*] A livepatch module, livepatching an already livepatches function,
    can be loaded only when it has the same @replace_set number.

    By other words, two livepatches conflict when they have a different
    @replace_set number and have at least one livepatched version
    in common.

> 
>         /* internal */
>         struct list_head list;
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 28d15ba58a26..e4e5c03b0724 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -793,6 +793,8 @@ void klp_free_replaced_patches_async(struct
> klp_patch *new_patch)
>         klp_for_each_patch_safe(old_patch, tmp_patch) {
>                 if (old_patch == new_patch)
>                         return;
> +               if (old_patch->replace && old_patch->replace !=
> new_patch->replace)
> +                       continue;
>                 klp_free_patch_async(old_patch);
>         }
>  }
> @@ -1194,6 +1196,8 @@ void klp_unpatch_replaced_patches(struct
> klp_patch *new_patch)
>         klp_for_each_patch(old_patch) {
>                 if (old_patch == new_patch)
>                         return;
> +               if (old_patch->replace && old_patch->replace !=
> new_patch->replace)
> +                       continue;
> 
>                 old_patch->enabled = false;
>                 klp_unpatch_objects(old_patch);

This handles only the freeing part. More changes will be
necessary:

   + klp_is_patch_compatible() must check also conflicts
     between livepatches with different @replace_set.
     The conflicts might be in the lists of:

	+ livepatched functions
	+ state IDs (aka callbacks and shadow variables IDs)

   + klp_add_nops() must skip livepatches with another @replace_set

   + klp_unpatch_replaced_patches() should unpatch only
     patches with the same @replace_set

Finally, we would need to update existing selftests
plus add new selftests.

It is possible that I have missed something.

Anyway, you should wait for more feedback before you do too much
coding, especially the selftests are not needed at RFC stage.

Best Regards,
Petr
