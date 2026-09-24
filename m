Received: from mail-pj2-f28.google.com (mail-pj2-f28.google.com [74.125.227.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B53D1ABA
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216459; cv=none; b=ewsARC1HNjsfxVMCnbCE8PtMEONYOmUjtc900mbyr+oCsOLAE7td4mjmA3b8OVrIvr7XMh7O9JzNjG2ExR0e881SsQaP3raJAk9Makxfh0ndB1lybtnmjA2/3F3ipcp26KC5cjmhB/TI/kXzXStj1MoYb0VDv3yHqYWvfHuBCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216459; c=relaxed/simple;
	bh=lcL5Eetl3nG3gsUqwm83uBVrTGBkvNDFKF7rcFmnNeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TQx4nrXRrscy6JF8lT9oLGtsFDghHQVfL4ysS3CyGB3IWP7KGutZeKF543FDrvEULnVVkkP8OoCyIPvG2q3ZkFZnLNWfDDXBKR0C0P3G9+bYe9R+FcnJPdJIO+mGiSJssRHIuGFLoUp6gmbp7Jy34u809iASilhQFIQso6SXZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCZ2Yfmk; arc=none smtp.client-ip=74.125.227.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCZ2Yfmk"
Received: by mail-pj2-f28.google.com with SMTP id d9443c01a7336-2d91c22d27dso6194725ad.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790216457; x=1790821257; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1OywjhLcf7AEhGOTuREC2CMLevxoLPp6meiFe7hYNSE=;
        b=eCZ2YfmkNf4A0dspZwt92Q8K5g21yl9N5y1EctpberS/8Ha4zbwyMdbiYDNf8ezbf1
         NVX6fzPU1cQiMyK+pg+y3zYWgbAC7LdVqeF5IpYtZj7vKWU7jCnGj/ZG5fSNtv3aQlaT
         eGl29sjcNiOVzPYyMflrnEdaN3XNN5PR19cHaCi+V1sTv+mvS8GvPH+FkVayHNGMltnq
         S4iTuECHrKa6vcjr7807YYE0a4RN+BXYNsPIOg5ZKqEXI2IGLwIlhOZaghiJtyGgeDrz
         ZgSKKFbCm73sITZzz/ed/IG+y92/4YRlaRd90zKvbGt6guXwhvQkFNozEpUA91LXpG0l
         Ehug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790216457; x=1790821257;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1OywjhLcf7AEhGOTuREC2CMLevxoLPp6meiFe7hYNSE=;
        b=jKAxZcR7ulvEKjGQTfBPGPOpAEUBNHydMWxAincIGEgXOaDzKXt1VZ3/inDi/qJWwU
         WbvhNk7sdrWBkJcluMOjwe0mH8vxTi15M9wxbBye/SD23bbGptoPicdOlvWNGXEzGJbV
         l/CVB6MqdH7yM52Y6ZpoMRJGyek6dTGPXDULUV5wRpAIq/X1Jf8KF4jiKmhfruQRJvT4
         eva9YIzQGDeWABxADiqxSA+7XGY+wSRzaUkuij7qmzFUMFQxgsI/oTnxn1LZaL4B0nzB
         TDuMMcFRNX2KJRCgLxtun90ycrYg+UpM/b6PAdFGXg4ujS4TFwY/B2vegfgw650bmlYx
         YgFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgk/AKVIEI9SCgWQRuJjStl2yyV0rjrtUL5XY17t79rlVv8zjWwqHU4PdBdn1XoHTzkH0=@vger.kernel.org
X-Gm-Message-State: AFuF++lEFsxyKmMjv56lQF1jlEY8mnvMyK/BIbAYwngBKmcPw2SH+I0q
	Rv9Lz1oyVQ7lmMmaS+8JRqhhP2azayoapCUBCiqK57kPw6vr1whgxA5n
X-Gm-Gg: AYBFou0Zhu+2INaepYVn6E4+yJwmwEY/oPU/Fwsc0X57OOEyDg7Wn7xi6wrHA6mW0RO
	CM6KNBSmI46aV1WoAyvxB8X3NzrxK7VkWkPz3ff6ymsCvUW8/UY5Nw7KRmRzG8lr2PWR6NfdMJY
	+PbpjToUqiFrLljAuFBLDuJN+ZkUWsj+XNNe2mxwU7tFyqfXJja/lbERX4cd0RR4jgcmPznhUM7
	CxCZ1mdSdhGyNSjlwNan0uJxLOjINFvx2ZCaWl+7VPGA0vilRfTbUSqKPjfOFd0caHBYK5vIM9p
	oiuCrpVvGHYZG782HUXg2z0kky39X4PAXEXoZHj+k4h33pKhbdYsL6hFS04qg2avsiUcw3oCWa4
	WMamqovbAwnu5IKtu/tUffFXn/NxGXigarOZ1YOMxE7f2lLHCAwreFVuAmkBMjLo0W3ytZ1Tghn
	w4Tq+j4+ys1nmLf1j3iC61heppzHKXdKqmM+HBxU5KwhdxZxznIsffbVI5AmoMX7aU+9t4IRtFb
	tojRa8ARwiBJuUKvOBTzZdQ/dBDwG/RhTnsFqX0A4VsykvvqsF1NKVk2Er8F5Z1cOgcKOr4mROe
	PBOgHRlWJVL5wg==
X-Received: by 2002:a17:90b:540e:b0:39e:6a7e:ee1a with SMTP id 98e67ed59e1d1-3a098da41a6mr835896a91.38.1790216455439;
        Wed, 23 Sep 2026 19:20:55 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a082872cfasm2420945a91.2.2026.09.23.19.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:20:54 +0000
Message-Id: <DLN6RPOBSYOQ.13B97Z6OSFXY5@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: fs/xattr: don't assume the inode is locked in
 path_unlink/path_rmdir
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrea Parri" <parri.andrea@gmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Alexei Starovoitov" <ast@kernel.org>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "Song Liu" <song@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260922145530.369775-1-parri.andrea@gmail.com>
In-Reply-To: <20260922145530.369775-1-parri.andrea@gmail.com>

On Tue Sep 22, 2026 at 2:55 PM UTC, Andrea Parri wrote:
> bpf_lsm_has_d_inode_locked() makes the verifier rewrite
> bpf_[set|remove]_dentry_xattr() to the _locked variants, which assume
> that the caller already holds the inode's i_rwsem.  The path_unlink and
> path_rmdir hooks are listed, but security_path_unlink() and
> security_path_rmdir() run before vfs_unlink()/vfs_rmdir() take the
> victim inode's i_rwsem, so a sleepable BPF LSM program attached to
> either hook mutates the victim's xattrs without the lock held.
>
> Drop the two path hooks from d_inode_locked_hooks so that the verifier
> keeps the locking bpf_[set|remove]_dentry_xattr() variants, which take
> the lock themselves.
>
> Fixes: 56467292794b8 ("bpf: fs/xattr: Add BPF kfuncs to set and remove xa=
ttrs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 6cb8772679782..357a379ef92a5 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -472,10 +472,6 @@ BTF_ID(func, bpf_lsm_inode_rmdir)
>  BTF_ID(func, bpf_lsm_inode_setattr)
>  BTF_ID(func, bpf_lsm_inode_setxattr)
>  BTF_ID(func, bpf_lsm_inode_unlink)
> -#ifdef CONFIG_SECURITY_PATH
> -BTF_ID(func, bpf_lsm_path_unlink)
> -BTF_ID(func, bpf_lsm_path_rmdir)
> -#endif /* CONFIG_SECURITY_PATH */
>  BTF_SET_END(d_inode_locked_hooks)

Christian,
this looks correct. Want to take it via vfs?

