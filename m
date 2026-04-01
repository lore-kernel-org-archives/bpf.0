Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967233F360
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072200; cv=none; b=Ty4SsU9JC5bqKsAcxl1y2HrvAEZ+6CJPjfwTzv8r0MxMKy5s4FBc0d8U5YCJP2H6Ief8aIFTxet7DvVd8hsvhl8pa4lwPlMM1wZIg+9P1txWQ+jLJLdZYGezOJtZh+UytRv3E4h7S/cP9u8gmB3FS/2fi7/FZRmkbfhoj3zWfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072200; c=relaxed/simple;
	bh=k8iCzq4uXuWiQ7sSnyd4BFnn87cHQYKsJi647NaeFgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVr6abnkkij5oRRrsQ/FaqedyLFBHq+FLf9Ecpx5T7ILclqBIPcn5fmHrs5mtVHKIQyMsUiCUa9ORxiM8PgCSgxDeCTqlvLOiztwir3cm6sOx4Z2GC+nUr/p605SOkf44/62R2IS9dWyjRJTuBph0lDZKVZegLKK1J9VEs0H0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjvWgrhz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjvWgrhz"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b3488fb31so19296901cf.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775072198; x=1775676998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVrIgOJbAe90gIl6PqT4GLqxirrLktAJpkeM2AM1fjo=;
        b=NjvWgrhz4s37VW7bXlhjSkik8jw7JMF5SYqZKtACF6JQzeu1EqjcoX50cW8UfiQkC3
         DOGck22LIfacbYmMDPamJ4a4Khsn0sTpIINATNovvkBT3AViU6ubhrS/fWAZnp5Ar+TT
         pwX0jiLECay4wTymQD6aQmqhkE7zXkWbbt3+Flfb4MPvfACJoaFY7CL6YqHCMEXoi/OE
         CCRyx3zYKUordvtMZWAZFB0oWS9Pjqt8r0R8xPD5y69l4CnvDdCnPcqFjyRn9cPASlZZ
         sR+70J/7or/LJGQ8szuodHD/2MqWmPqUs/5I1L87O6vceVlAPbdS6CFDkeGlpvNPz3jJ
         13lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072198; x=1775676998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZVrIgOJbAe90gIl6PqT4GLqxirrLktAJpkeM2AM1fjo=;
        b=B1vKsdryTwpdc6IDPOpybmZoJeD+O+OGZb6hDZfq4gMyO3aqisNNOY+NCNbrpIPX/a
         tYlmRDlTBJSStr7WDB8nG+FxSQ5r9M8RLU7jtfhNmx2IdHIZt86gWG+HBWKOgwKEvc0f
         hwUbZm2lwgwuIANaCAyjpNP//v1LtxTFlhR54GcZ4Nh+ZOqTT7MW5QcETMalakPnJgVv
         90F1cBdqpZfMBr3ireY1rIl0PRqsRb1kALHDQ0IICBTtj1rpe3IxHCQe+nBAP4TG6Fwm
         OyFICy9t+ziZdzJcLKGw8AxVtG1ryACP7T4o3TR/I85zQfqZ/m715z+CM5V/5/BchQDb
         jeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGKdmKlMt4ATXF57t4ixsc+/vXu9EZ9b/vXFsUtUui7FlYYzKhY/P90H1NOLnfOdHGETI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzOdqFkE+7n2EJc3hHrhsEBMllVBxPOhGEICbck/48Td8rcWr
	uBW0HYoyxksfvHL9EgceFnJqk0MQgWat/HIj4yhc+CpgF0p5ts6VinJn
X-Gm-Gg: ATEYQzwzkS4naOex9AuRECFXzBSHfxfMlobCc1zKQlbtyU7rA6AU2GgV2ajgx7eYthA
	86z1/0fmceqa82bQmCPHgYSOsmhbDS0GCFTRsLKj5LamZighlksC0y3jO/yrOGaRxx9OkJteuRs
	FIKhKs262t6rnFVhKzxDepOdTlsR8wPPHGb6Zf1KHoRRs/YDKN4WVCbADgb6sMpb2ehOMzSTsKN
	o0MLwthZ0DE+XuDJQ/Zy1Dzmr8LnCCKCSyYtO4Gj9nggZrUIsMJ3/WOU/kzqsc2FizZYL0t2Obw
	JIy4gDLnLDW0G/ezZdWqmjtUW9IkkGFy5OJPBkTMBJCkNcW7rvIEnOS6l5jtRfK+qKjRiCE4y4D
	J7yLghRw7n+kmbKFJ257ruylqm8PscKG97oOzJ/KfPfVWGneVmVNZA3siQG+dbOKDkpViiAiPJg
	M+2ps3LgL6LaiMX66lQXLtxdZJyOr1T1iU6+L9uETFCxJCGtLVc0Q3NNKIpv8ZhOSoiatG6aFIy
	VjCwQ3mW8rE9CJELBqOHa7myrtXJWM=
X-Received: by 2002:a05:622a:87:b0:50d:3efd:bd93 with SMTP id d75a77b69052e-50d3efdc340mr47910051cf.11.1775072198355;
        Wed, 01 Apr 2026 12:36:38 -0700 (PDT)
Received: from lima-default (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b93dd05sm4896571cf.9.2026.04.01.12.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:36:37 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: paul.chaignon@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	harishankar.vishwanathan@gmail.com,
	santosh.nagarakatte@rutgers.edu,
	shung-hsi.yu@suse.com,
	srinivas.narayana@rutgers.edu
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets invalid inputs
Date: Wed,  1 Apr 2026 15:36:30 -0400
Message-ID: <20260401193637.14694-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ac0NvOIc7AhifyNM@mail.gmail.com>
References: <ac0NvOIc7AhifyNM@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Apr 1, 2026 at 8:21 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> On Tue, Mar 24, 2026 at 12:33:51PM -0700, Eduard Zingerman wrote:
> > On Tue, 2026-03-24 at 15:28 -0400, Harishankar Vishwanathan wrote:
> > > On Mon, Mar 23, 2026 at 2:47 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > 
> > > > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > @@ -2786,8 +2786,13 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
> > > > >       reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
> > > > >  }
> > > > > 
> > > > > +static bool range_bounds_violation(struct bpf_reg_state *reg);
> > > > > +
> > > > >  static void reg_bounds_sync(struct bpf_reg_state *reg)
> > > > >  {
> > > > > +     /* If the input reg_state is invalid, we can exit early */
> > > > > +     if (range_bounds_violation(reg))
> > > > > +             return;
> > > > >       /* We might have learned new bounds from the var_off. */
> > > > >       __update_reg_bounds(reg);
> > > > >       /* We might have learned something about the sign bit. */
> > > > 
> > > > Is it possible for the invariants violation to manifest after
> > > > __update_reg{32,64}_bounds() calls, once cross domain boundaries are
> > > > propagated?
> > > 
> > > The short answer is yes.
> > > 
> > > The sub-sync functions, i.e. __update_reg_bounds, __reg_deduce_bounds,
> > > __reg_bound_offset are individually sound (checked by Agni).
> > > This means that they preserve any concrete value x that is contained in all
> > > the range bounds and tnum inputs, after refinement.
> > > 
> > > But if in the input, there is no concrete value x that is contained in
> > > ALL the range bounds and tnum, then an invariant violation can
> > > manifest. Note that this can happen in the presence
> > > of the current early exit commit, i.e., even if
> > > range_bounds_violation(reg) is false.
> > > 
> > > For example,
> > > 
> > > before reg_bounds_sync: s64=[1, 1], tnum=0
> > > after reg_bounds_sync: s64=[1, 0] tnum=0
> > > 
> > > Could you elaborate on your concern? Did you perhaps imply that we should
> > > be checking for reg_bounds_violation in
> > > simulate_both_branches_taken after each sub-sync function?
> > 
> > My main concern is that we might loose useful signal.
> > It would be nice to adjust reg_bounds_sync() such
> > that it would stop (e.g. return false, as you suggested previously)
> > if it hits invariant violation mid-step.
> 
> We discussed this with Hari and agree it would be good to use
> transient/mid-step invariant violations as a signal to improve
> precision. I'd however prefer to implement that as a follow-up, to keep
> the current patchset small and focused on fixing the invariant
> violations that cause kernel warnings and program rejections. It sounds
> like we may want to backport this at some point, so it's easier if it
> keeps a restrained scope.
> 
> The "transient" invariant violations already exist today and using them
> will only improve precision (potentially allow the verifier to accept
> more program than it does today). I would see that as an improvement
> rather than a fix we'd want to backport.
> 
> Hari thinks we can also use the empty intersection checks he mentioned
> in the other thread [1] to avoid/use these transient invariant
> violations. It would allow us to use this as a signal to improve
> precision without making reg_bounds_sync more complex (and harder for
> Agni to verify). I'll let him explain, but as mentioned in the other
> thread, it still needs a bit of benchmarking.

The idea is that since reg_bounds_sync() and its sub-functions are sound,
invariant violations (I'll call these range_bound_violations) can occur only
when the *inputs* to these functions themselves have (i) range_bounds_violations
(ii) an empty intersection, i.e. there does not exist a concrete value x that is
contained in all the 5 abstract values. Let's say we have a way to detect empty
intersections (as discussed in the other thread). We early return on empty
intersections in reg_bounds_sync():

reg_bounds_sync(reg) {
    if (empty_intersection(reg) || range_bounds_violation(reg))
        return;

    __update_reg_bounds(reg);
    // ...
}

That way reg_bounds_sync() preserves empty intersections and
range_bounds_violations, rather than allowing the intermediate sub-sync
functions to "fix" them. It's equivalent to the idea of returning every time we
hit an invariant violation midstep, without the extensive code changes

As Paul mentioned we were discussing empty intersection checks in the other
thread, and I agree the two ideas are probably better combined in a follow
up that: 
(1) Introduces empty intersection checks 
(2) Uses them in simulate_branches in addition to range_bounds_violation, as
discussed in the other thread 
(3) Uses them to exit early in reg_bounds_sync()

That way we can keep this patchset focused on fixing the invariant violations.

> 1: https://lore.kernel.org/bpf/CAM=Ch05-XWF-x_VzUZAWhRO9eum-bjdutuwvPXEcOvnx_0omAA@mail.gmail.com/
