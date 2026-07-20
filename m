Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882E43711B
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571142; cv=pass; b=C1GhAOULq3nq0ZNxosBJFjfP04HRUoVg03xpLxhdRJHriqq1wZHHjBu77+SIjMWy3rpnVBpk7a8c9DhC7IP2Yx6yKCXYt1aiOPH6u/NSaYa9tcZ2OJhuwbSwDHBMDXXTTeFuyoNFiBaGJf0IPyp4Rk+hpnWf1kpXAeMlN34N08U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571142; c=relaxed/simple;
	bh=1JX430VNbqj0hZ6Lzk0OOAcmh3W6k774gqZhhQCrP/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd0ZVUAoP2KtKx8mAAmC5omdZHGcOt5wwaywHONueYF1FHOgXMO0aGrYBsZGhrIBh1vZlCKKM6dDLoB3PbyNh4uZowyRl4MTh/NsbEIGd7iC5iVe2KlzDFzzcWJAxAmk0zo1DOev0/THCUP2PImvQ/1YN7AF4Uh12Li5NDfWfyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWLp4eZh; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWLp4eZh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caced6038eso56745035ad.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571141; cv=none;
        d=google.com; s=arc-20260327;
        b=AZQDzgHyuYcvccjorSV/hv/i0HAHEeA6WrA0kX9F5XMqDjdCpz82n6wOAr4CedYJsq
         UQcoaMUCShK2DkdyIjAIy7O/jlAr1sFYGNOrS1luc3HBvE7q5X2vWT3EizcIGHGIMEM7
         HsOlvllBwx6RWgxNxZHhf3Ox8Aw1U8MlHoOY6jdw9Wf8cKYlqAhKQtHIBwvf5f84xdQH
         YIAM5H6hcB7HtoZ9c7Dsq30exxOwM6sW+qzJMyq70+Qv67paAUjdwB0ADhG2TPRB7yn6
         3J6YxKvYnJ38yEC1XtVZU82b7ngkjLPJ6LZzAk8pH1wQ1ZvhsXVsg+724buFCp3hnH5u
         T5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        fh=sRbZy/g97ufJJzvl1728gQk84+HYF5qgKKv/woF+9Vw=;
        b=jpKpMThMj1VUVAT/cscU0xwLlXarOHKw3jzAqRlPP2Oup+1+xG2ZT2rYYpGI27tyuf
         /1gtrYpTWyW7uQil4rOs04YA4lsoym40Q8OGRhG2hrILZ3tS5HbYOZcR3wxhfoZf9wrg
         Wuxbxq0sMaSt8bkGdRpUpC5lZzf1R0J4Z5o8C/PZmkkcQMVtv6IJ5kcPMxsqoPKfXAZo
         t9h6JmhyANjxhDTmILnVKne5+actVcEShbNs2r+axn0HAocZrE2rrgRthKT8goz13d+5
         LZWlYgYkBVtgoqvA8UgiNFxlZ4STUJGuSZHZWEGOh6LNwIbrIKGFXCWGH/uwURFptUj4
         QJPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784571141; x=1785175941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=KWLp4eZhCGEaAiHAaTC37TOMSNgeCcmI9tjMngAHzbisyIIl4DD9oLzg+2o95wMPsv
         hE6y6Jl2R+fRW6GE7j8EoS1lgNSWUYXfvXHSml+nSoWRFyXNmaPRqI3r+WomGDlOOfse
         KEN5FUQx/u367rVVi8P++/X65Pg7d86mfGno+CcG8y5Z4Ww7bl3cicaMvNnU94ZyGf31
         tgRqMiLTY80YuoEfpKD/fgdKKmmq0VGW5CPlyeiyORPA5gn6NnDOHFi3fY0LAKS55pS7
         zlCeCbqa0b/kzaq5RD9bgq2lWh1NGTSIzn4cGQvlFvEodoT9KXZhOkSsuPwxBpSCMOZq
         b47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571141; x=1785175941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNJFFcN3wjr5bUpQXM7xbGj3SPGWcRQviakfsaDwtEQ=;
        b=I4yqNYXo4SAHVEaQY8oXMccDasNXoVyGfec7MM80VYGJgvZxkMsvoUjR6I0t9mIcFY
         JD/QkK128OWr4SBDJ0vXhDetjnD0p2qra9YJkzvQB3YmiM2CbUX5+bm6oF/XyiATN3XA
         TdI++qsr9EnIfUiEjkcY64W1ZjFRofNuRjURYwjunFnxHaPy/cWK1YuSHF5OnXuLxi/S
         whCoLec1DE0gvwyUKoXISkI4OKPpmOwz6+mCxbHUlZXUQM6/CNJLrmgAoh9XJ6R+hyZ5
         87BOUMgpE2hosy5sGrOjKPErDjRXOkPgg6nJJy2cDwX8T5TxSBbYfXMfyPC7X2+jSIIe
         H47Q==
X-Forwarded-Encrypted: i=1; AHgh+RpXSuH3PhxqHZin3kMIT7O8PV+i8vKmL04KuAmnCAGZrm64sDZKEat8/yDTPqIMDDqxYQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUFFV55I6A8VoIX4OFt0DMnQai4LJpHigUlyaO/ocoFrn3Wfl
	k+TKXEGFLGZmjqGm1CxWKkvUYUXoVUlUtIcFrRfyIEjMTqP8MuQdGbuDuPY0yPWwtKMLpjw6qxc
	eMQ0ykxeDu70GQzQn2+fymDsVK2YzMCY=
X-Gm-Gg: AR+sD12IrzCr6Qq/qSy06byVZju+E4/KU3l25XVaJ82JE14sdYLvBzoq9sz3uV03gBU
	TpI3HfGxnfWYlPv4Vi26jaxYt2uX3P3HTahAw0jmxuhmIct2onk0yfCZ2l188Yk8JPcNL9HraRH
	kwoOQ9liy+r22OzahdMzI/I1rbVteIMkPwL2K7CiZnu9/WfRNPy5FRkh7LR/+AXEXS4Np3AEPxl
	YMPtq5Xj/Wrgwfyjh8cG2QsgGkQgfWI2veKUOOq4yaB8yQi3fgF2mTL8/mq2b+o9XIMRAbRp3ka
	bLy87GQNMP3jaVE+
X-Received: by 2002:a17:902:ea10:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2cf1f29ea6amr213030675ad.8.1784571140752; Mon, 20 Jul 2026
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
In-Reply-To: <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:12:06 -0400
X-Gm-Features: AUfX_mxSx6cvDqWkeZpCRVrryYfuXxFSwFH_5FN2Ivh39vzoR79SkwFUGoqzhZo
Message-ID: <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
>
> I'm sorry David, now that I'm seeing this function again, especially
> with the LSM specific bits extracted into a LSM function, this absolutely
> belongs somewhere under security/.  It's only callable from within a
> BPF LSM callback and all it does outside of some BPF pointer boilerplate
> is call right back into a LSM helper function.
>
> If the BPF maintainers aren't willing to accept that, then we will all
> need to find another way.
>

Where this code lands doesn't matter to me, so I'll stay out of the
decision of where it lives.

If this kfunc goes to security/, would we also want to move eg
bpf_set_dentry_xattr similarly?

I'll roll v6 of this series meanwhile and we'll see what the BPF
maintainers say.
