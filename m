Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B132B104
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434819; cv=none; b=OyKDMSDl8R3XhOQcgOjh1R6Wbgu9/iYuFkTAxy/AxR41VwTIsOgSaOn5ELzu71e2kxZnHHQBC2la0CODosJhdTWJuyhfRJ24RDzhingZgfV/TlUS5kCU1W8UxH+/tdd/lNtTRshsNjhIoBqrIGskg3YjeOl1hrsionPpBS+1C2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434819; c=relaxed/simple;
	bh=fcHrDu5TcVGUbQYtMsbTooLgiV/C5TNdEOFz87jsXsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+1XwVOZ5AHaqBYvgIIkr4qEM/6Mna1L00K8rfoBFuU43tahh11WBAXTCzJTKDHGV+JHJMKeUFevLX3n9093v2MBd6APpqRKNAtFlkhwePXNMTQLhDWjlueTdJNMoc8AKjw2jsQ96Edwz1ZYEbc0OC1cM343nHBhZoCyLNaD7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg8WsPpk; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg8WsPpk"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d46e4cdcdso23082587b3.2
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434816; x=1790039616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0xpo2tKv173wOqrl8/LJ1AsOUmZl+6vDFMoc100h0gE=;
        b=Xg8WsPpkgJVqYcUyvF0VblJq5fda/B+wdYNl9/g28FOafzvgjJ8tHv9cIbLkKhNCCF
         VybQamndDJA/WAEKXIgo6GeXeYJCpBJr6OIaYlCrU/HGlqvKrKpubIn499PtTro9WX6l
         VpN9NiUyW1wa71XxjechDXTM5o8HXTlZTAdr8WIWOi97pZKvnzNwQehRWBnYMVPEs67l
         ulxHlw2bs8i7DdNlb3lxFMB1634+dnidE1UPAT0hXcrpRLNvzDkFW5E50hK4Xl+QWlDJ
         IQQDP1mE/sQCqHT8feOxaEewyDkzeTqK6HUej2ZfE3Tq4r5s9OjS/npTavNxNh6Hscpa
         chvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434816; x=1790039616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0xpo2tKv173wOqrl8/LJ1AsOUmZl+6vDFMoc100h0gE=;
        b=WSCim7I6Ie3XzZIjrqX9Pwf4CCIm+1RV3srfLuBEUiZferaHPp8ju6uSWmwbmFpgAM
         KLgLVX6M3PU0L3xnM/wFYvjuKnk5Ukl2tLtZPivoN4Zfcb4IF8a4JoBNhPwtKSsE51ah
         oC9Cc5YTF/GOY2tqB2kgECHYrb0e8fOZ1QGEpwWsLWLcefOeBe3MQwiGCu9qh6WQrOQX
         4LjmmpGC5qMMlzKLauhp2J3j6uwYn0DpG705Alhr6kUYkNmyxW0PApqPdWm7sW3AEJUg
         Zd1utF2QImwM4iFRIKCIASypgVNeVeE9HiuD6kZRiTsa2K4X3TY6ndwkYh5oINuVwcfb
         97FA==
X-Forwarded-Encrypted: i=1; AKwUvBxm07zhjwi581wwypFHn6k+ZyzPCiJdPuC/X5/cG3klsKqRKFyn5o2zDESHbWTQyWztSPY=@vger.kernel.org
X-Gm-Message-State: AFuF++kVdz9crN4VvtJKGWdVKYBlsz0W4I4LuwzJ+ZAzoPrmfDdnAYcl
	LZn4DqZKXRKmGaSqEp+VaOG7dTXKgkNppMLujD6PqGztwu1D83YYY++/
X-Gm-Gg: AYBFou1EbAfNewTQ8Jy4d17loeRC0/7QbiW3BCI18RklwDzWvmhWX5xD8E1l+Gvi+Iu
	rsMORfmxSF5UUGZZqmMATEq6tT3Qi1L8CbDjk7OP4P4DhN9RnmiLmQJYW903afOGtqWOy+qmNww
	MeW4LjZBNf7c/j8agGbOWst5gG/Ji1718fdr0R8ninnJw+xxqHMbqu7XedrC2Tfifg5ifm/TMwH
	wj86AcRqPkHoo2iJiHrxzm7DHxSKuapab8tfklaeKrXRT4P/AZOiPxl8oc7R2B/oymg99Ny8hsO
	NWqp+K8A27Kuzcq/ipo60VleqZUAiGoesP3tpjg4SEafk9M626JKzkZBgHXnP+kzXcHzL0u09HO
	VMhjCO39oPnXip7BP6Q9nJHHIDaKAhitxpU5XoeGnXESN/QLbH55obisfUGcN9C2bsoI8rDOQKm
	52bMsw41FLbcAhjhme/zzKlYNtF5ghReLV+0rjfupgGOJUq21FNWv0pNWTIQ8DrHjDDQe8vCobW
	DHBAettX3CQiIeqIHyyHrUS8jNy1/TWLw==
X-Received: by 2002:a05:690c:e208:10b0:87f:a9c6:470b with SMTP id 00721157ae682-88d1f2138d8mr17209207b3.2.1789434811483;
        Mon, 14 Sep 2026 18:13:31 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:fe9e:c133:77e5:be16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88487ea6026sm42364337b3.32.2026.09.14.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:13:30 -0700 (PDT)
Date: Mon, 14 Sep 2026 21:13:29 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <aqiJrkNyGM6hYu9A@zenbox>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
 <aqcb2eXw61LaFaqY@zenbox>
 <CAADnVQ+v9_a8Q_YOvS9fmXG+-Ga0ADKrjGDDUCiFaipo2vUDmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+v9_a8Q_YOvS9fmXG+-Ga0ADKrjGDDUCiFaipo2vUDmg@mail.gmail.com>

On Sun, Sep 13, 2026 at 07:31:44PM -0700, Alexei Starovoitov wrote:
> On Sun, Sep 13, 2026 at 5:20 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > Sure, in some perfect world in the future where every verifier
> > challenge is solved and BPF has feature parity with in-tree c on
> > a 1:1 basis, you could implement something like SELinux, or Landlock
> > in pure eBPF.
> 
> Try.. give it a shot? What is missing in the verifier?
>
Howdy Alexei,

I'll stick to Landlock as the concrete case, as it's what I'm most familiar with.

From security/landlock/fs.c: hook_sb_delete() holds the superblock's
s_inode_list_lock, takes a nested lock of the inode's i_lock inside it, takes the RCU
read lock inside that to dereference the per-inode Landlock object, and
then the object's own lock, which is four levels of lock nesting, and even with
all of that it still has to handle a race by re-checking
inode_state_read() for specific flags to maintain VFS invariants.  BPF
cannot take any of these kernel locks, and the current BPF locking model
deliberately excludes any nesting (bpf_spin_lock) or resolves contention by
bailing out (trylock style); the opposite of what maintaining VFS invariants
requires.  To do effective inode-based access control without TOCTOU or
bailing out of a long path walk, you'd need to solve nested locking with colored
locks: inode spinlocks, superblock locks, unix_state_lock, etc, and
solve nested locking along the way.

You'd also need to convince the verifier that an upward VFS walk
(dget_parent) is bounded, and find a way to cross mount boundaries;
getting from a vfsmount to its struct mount is container_of(). (Pointer
is arithmetic rejected even on trusted pointers).  Pointers walked
via d_parent become untrusted, so they can't be passed to any kfunc
(bpf_path_d_path(), bpf_inode_storage_get()): inode local storage,
which is otherwise an idiomatic inode security blob replacement, is only
usable for the object at hand, but not its ancestors required for VFS
walk.

Making it string/pathname based instead doesn't help either: any string-based method
fails because the same file can be linked from multiple places, the same
path string means different things in different mount namespaces, and
strings aren't TOCTOU safe (the path can change during the walk).  And you can't
currently take references or locks on inodes, dentries or mounts from
BPF, so any hierarchy walk is a lockless, unreferenced snapshot racing
against rename, whereas Landlock's walk holds path_get()/dget_parent() 
holds the references at every step.

You'd also need credential-attached storage. BPF task storage has a
different lifecycle, and is no substitute. It does not define how policy
is shared by threads using the same credentials, copied or replaced
during credential transitions, propogated through file->f_cred,
or synchronized across a thread group. Recreating those semantics in
BPF would require explicit BPF APIs for credential storage to be
consistent.

> > Why force every eBPF program that needs to make security
> > decisions to reeinvent the wheel?
> 
> What specific reinvention are you talking about?
>
Path based access control, done to the same correctness 
level as in Landlock, (TOCTOU free).
> > BPF already calls into LSM through security hooks. This is no
> > different than bpf_map_create hooks.
> 
> what? It doesn't. bpf progs avoid lsm hooks as a plague.
> Not a single kfuncs calls into lsm directly.
> It may call into security_*() by accident because
> it calls some kernel mechanisms.
>

I was referring to the security_bpf_map_create()
call in kernel/bpf/syscall.c, where BPF calls into LSM via an LSM hook
just to show that kernel/bpf already calls security hooks directly
(and now that I look, there are other security_bpf_*() calls in
kernel/bpf/ too).  Those hooks exist so LSM can mediate what BPF is
allowed to do.

(These in this patch hooks are contrary; they are giving BPF control over
LSM policy. And, indeed, no hook is called from kfuncs, as you stated).

The proposal is intended to add a narrow generic bridge, not to expose
Landlock-specific kfuncs or make BPF depend on Landlock internals:


  /* setup (BPF_PROG_TYPE_SYSCALL context) */
  obj = bpf_lsm_policy_from_fd(fd, 0);
  old = bpf_kptr_xchg(&map_val->policy, obj);
  
  /* enforcement (sleepable BPF_PROG_TYPE_LSM on a bprm hook) */
  bpf_rcu_read_lock();
  obj = bpf_lsm_policy_acquire(map_val->policy);
  bpf_rcu_read_unlock();
  if (obj) {
         bpf_lsm_policy_apply_bprm(obj, bprm, 0);
         bpf_lsm_policy_release(obj);
  }

BPF never sees a Landlock kptr or any Landlock-specific type.  It holds
an opaque policy reference and invokes a generic operation. The LSM
can evolve its internal representation and its hook-specific
implementation without exporting breakage into the BPF ABI: the signature
of the data the LSM sees can change independently of the kfunc (that's
what the body-less hooks in patches 1-2 are for), avoiding breakage and
easing refactoring.

> > Nothing about the way BPF works changes with this patchset.
> > There's no verifier internal changes.
> 
> If the verifier is in the way of what you want to accomplish
> then please improve it.

There are also verifier improvements I'd like to make, (I can also work
on these if you desire prerequisites or seperate fixes).

For instance, my silly bpf_lsm_policy_apply_bprm allowlist exists
because there's no way to distinguish a linux_binprm seen from a
tracepoint from one seen in an LSM hook (both are KF_TRUSTED) and
it matters because there are tracepoints where it's no longer safe to
modify the linux_binprm.

I'd rather have the verifier do that legwork through its type system
than through BTF_ID sets, and I think you feel the same way.

....

The goal here is to keep LSM firmly *out of the way* of BPF business
and let each subsystem focus on its core technology. It's my belief
BPF and LSM  subsystems can benefit from something like this given a chance,
with a well-defined structured interface / guardrails.

All in good faith, 
Justin
