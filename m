Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C61D435F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789353118; cv=pass; b=B9gCuE7Wp9UaHdwH4G0WHAooNNX90TWZROzq+pBx7FwgejoTRmiz/24iz5xAl8L5ZLdLqsRUugEmnJPlFJa9Pp36AHBAFP6VXesXDbCPVDDx06BcdSmN9mpGJFB7iE1yYeNxfdzRbdO5AhlM++O9V28Di3JJsnr3sf+foRCdKww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789353118; c=relaxed/simple;
	bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0mDhZFpC0hslrnlTptK3FQbdbBGP6ih1LZuYNpByQUNWuDp8eUOe4+Y9KqUwceA/YfxFCDxQ6AlwRDdKzoj+juk0sBUHtKp6GrAgohz8lqKd3H0unV9qlSp6o0LzgH5/TVsdR5E0eTMuwF/qzoVdPU5cYIEiSy3g1BypiEAsuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR7RHqfO; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR7RHqfO"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so10350905ad.2
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 19:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789353117; cv=none;
        d=google.com; s=arc-20260327;
        b=QsDVbrwuF1hEBr7ubRbAS4eFa2UTb2RNcURi60+iZdQKL+/L78vazOYdYZVbZ/fQ7T
         XFkNdb7eE2kuz5GTbC/8N3QUNqaYAVMT4J9VCCwDy/PCy65yLLmKHjSl9tdKMrP7QYnI
         JjAMFSIuZquR/i6lCIBe+xC6g9GYidvCZuALPxQ5/7P8yI1Ss2WBSo06f1tnfavHQbe9
         eeHlzJwI3sulAD2cJYoOsAodu4kve3sWZWkvOXV05losT3NH4FGP4gd43ABk/wtsXpFT
         ycZS7TMC+GyTsk86CUr3j3d1UcyCKxy4jdiaGRc2brLGdzRIUEjZfpOJj+WGZyJQEi3M
         xz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
        fh=5SDjfHNGvB0UxQFpVkVmWlV1uH1olgkCSVIOaEWkoWA=;
        b=psuuWE5Q3pYeVFoUsmDaki36hJZ5tK5XL8MxRevMO+pnxqIu+n7RowAjEGCEkMQWVv
         s4wwtOvhJZaYzEi2hx7yk8ugC+xfCOeihEQjcs+yio31y+T2BwU7QCRHsRndUGh8wGfS
         zHePOGQDL5fqW1UIIbE6nWGD11CU7bvAhuje089rXuMSUwyZ/9APAwbMZ4NGcagbOrQ2
         J27QrAMFOtcWFWp6awjnpki/WQc0jlOT+zmyH327DPoZvnqkUfvvAeq4ayZ5fNtrBb3N
         nprg5pGRDRvg72Dp/tP+hbwvSenwiVvnE5UGMtmSXucg1U97VXYMDNk92eehmxzxESD4
         c7/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789353117; x=1789957917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
        b=eR7RHqfOWHsBRsjzCCOY/b1NL2mC8XZ5If2LevX+KTQVQuIs68/9VWnmBQ8UIhmt1a
         gbJ30ZQxJsc9mQTqeIVowRxS+LhbSMkLWRWpIq5Ylq5/6b3yxdBX5fRm3wG5N/bNtVj0
         DQHIpnJUXG5YGh4Vy0xKONcf924sC99VK3R+ChgRhExrD+ETlxJmHWG2Hnm21fnD8FCa
         tLYm12i6cPc20VQaqSkfIMDBZcpCGx9o2ch4br/p+5kc3fvU+CjhAtvZAxKvtqBqJ8e6
         AOAY88rQGUSvzFn/bNpkro768xa2F6M6GTXzRslAontz9DMazVMzYceEQXFYZv8zyjI/
         /H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789353117; x=1789957917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQq5ED2h3MKUld2mTMcqT6jbF/0aSpOcGOmydQ0401s=;
        b=JusGXTSZqaj1H6ceYI8/AB+e26vWvAkVRFRySSBjttsVE4weA+wMu8EcPHYLREpMKG
         ckcCqf4PEYP2P7BCcXusJ5EGmqH6ydhf/UbNqGYr1N742E+aw5xQj6XlXBRkzPaBh4q8
         mnfj3B4J5mJPO3+r9dBkysafYSi6GuSUoxrkQCHOiPqAjKgk5hZi7x+uNLDIQY+kwttP
         tg7Ezt330/WFvYkftJ9vLs1bzvytl4dTDL6iELxNHGHre3pdat4GRhy99GuIsSmxLeor
         pp9LRg6AQ1WoQ51BFIsAmE6N9hQ99mdgrmu/+O4g+EUsqkPbYUpWVwFWPrsZCM+klsy9
         GUBA==
X-Forwarded-Encrypted: i=1; AKwUvBwu7zX1gCzBHK8BtJ94hEFu3clR+ufVEB2ydmMHg+ZWmsRyVg9smDPF+d0YOZuyt1mxi6U=@vger.kernel.org
X-Gm-Message-State: AFuF++mAuCb1B1u6IWtqmB5eZIzh+MGVJ3Qb/6kc0zUCYiun2t7MqDbC
	A0PeWKXIasgtNPFa/EwXiHnu1ghEcglc0hTbUvwPXvsnjhuTUJXMvA7nRX4WLUjQc4jSDgTUEz1
	tor3f/rVr47u0+mK5ji6Vjan9ItrM7wA=
X-Gm-Gg: AYBFou1uPFDAGW4hZwU4QluzpWVL5MTwpLBiGh97LQudFZe/BejvPZaQcpj5Fy+9+Un
	AdTcZ7PLPFrL5hx4juF5ZmOqDx/vlmDuRTiYZ1Rxid9Bo7MIR0ioIwFkTwfeaHv6Z2aWIDql3rK
	Z1nsYVy6tVJgEHq1bZQk3dAaTp7KJNrm5/6xPFKJvlkdE1Up7XHRwZchtR+q3BbH3lXjGJ4avqp
	XMyoYL8s4j742v/IWS4b8/s0JMG3Ihz0cv6xwZ3lTI0oYr4zidf8mjE7rQatbyBKYYAu7lFapIq
	ziMMNEUh4xQfGty3rGRQTfFqzfxmSM8zeB4gBLxbZRZ7sPWLDe4xJNo1Kt+5xjjczBqTc+xvGsN
	A86BfrP3gKpy40KXRQp0InwvMdmVsUJAOPlidoe0=
X-Received: by 2002:a17:90b:2c88:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-39dec0f990amr1390428a91.25.1789353116570; Sun, 13 Sep 2026
 19:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com> <aqcb2eXw61LaFaqY@zenbox>
In-Reply-To: <aqcb2eXw61LaFaqY@zenbox>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 19:31:44 -0700
X-Gm-Features: AcwNN1WXBVEf_wzXbmqsfgloUj3Usk1t2ym6vBQneSX3XwH8eIEOpV46HQIyMkg
Message-ID: <CAADnVQ+v9_a8Q_YOvS9fmXG+-Ga0ADKrjGDDUCiFaipo2vUDmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 5:20=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Sure, in some perfect world in the future where every verifier
> challenge is solved and BPF has feature parity with in-tree c on
> a 1:1 basis, you could implement something like SELinux, or Landlock
> in pure eBPF.

Try.. give it a shot? What is missing in the verifier?

> Why force every eBPF program that needs to make security
> decisions to reeinvent the wheel?

What specific reinvention are you talking about?

> BPF already calls into LSM through security hooks. This is no
> different than bpf_map_create hooks.

what? It doesn't. bpf progs avoid lsm hooks as a plague.
Not a single kfuncs calls into lsm directly.
It may call into security_*() by accident because
it calls some kernel mechanisms.

> Nothing about the way BPF works changes with this patchset.
> There's no verifier internal changes.

If the verifier is in the way of what you want to accomplish
then please improve it.
