Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CE3BBFA9
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578589; cv=pass; b=X2ZiCjO76ak0Fg2TNqACdtFyTuLSW/HGLz/QXmGc2xCFuYlvkR+RB2bcujMucTcEE2HhkZklu12As975HMvTwe0ATnsHaAvUYA1HD8BTi5U0WvUl9SAwA3fF344bLAre1pscNBbi3twRBIH93wjvyF14uCXWm3E/9ufPgNuCNXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578589; c=relaxed/simple;
	bh=qOEkNLJrOibH57gOt/DIm3R8ct2tEakFik9JpGI7f18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nE/pTkYRroJ5Q6+vvWnXqlub78wPcKHUWZB8iZxucDqZd0NLBaPWQ+Kb4yt7ynwzZDWksiWbA8818xhD2wkdE0S9DbRe5fortYkISVhHEnaaI7+rcWNZXaORSBJtot1ehpp3j8mzvnRKfijgNfw4iBuksNu6FYP820aDYz6nqjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d2866SVJ; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d2866SVJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485b358552so11375538b3a.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784578569; cv=none;
        d=google.com; s=arc-20260327;
        b=MR3kGO5Sxx8DEzA8dKBiXdNhpc/35MNZguYuBPVMpRnzrS2yzRrnMESFcx6sCiNcGE
         gOXAcLdqylf3dAQoSNm0p/HYuJwN0+3tbH7UNI3YXzR4AV8zIoKudrLPWQqeDmOy+9LT
         8ztcrsmqCVusYHdmNjE5IWk+iOfsmOJUwFy2n8J9haeGy0eI2CPYDgMS1Tm4pIS7hBup
         mzYhBxolltQiJWRTMJ/gg0ra2h4EvL8JqYodxPU7HCKLI1LQztqAYIZa1kr4xTlWxOlW
         1Il96ZFW/L148iECnUrOyrshh0ZRwflUXMTcc75FXfNrb37SbfE7/oSV95NNJ+Vq8ByV
         Xkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEIzKGx6nstnSDXiYsrtWuuGIdEs+ij5HpQm4P2etZk=;
        fh=H76jlso9rt/WI4d8vbXKnGEItepQQTa5NW4H7nTJJcA=;
        b=A4u7C6nvWj09zAbYVBMFU4nFSoXvncTmdOgVZiKCviiJXyooQhqnQRnsvbM65pVmk0
         dZ83fxJC3xEm99w6FeH/P4Dh2Dk2rq4Pc7QL7SWVJz8J5DqofhuBX0eegDJFen9DCRTC
         hws39nxxVPsIY01ghhxWR7VhkxrNEznn0MSCTwOVHwnBzX0Qlp13CSmZkkk3HewrNwcy
         7Z5gdxOcOssv3JCT22e3CcegO369rHCO2t3f1Qc2zVh7Iwpr5Q4fqFaTh7NyMedXkvN9
         +dWgJIgYmOE+JPJMYhb6l+uUrdv7BnrcdAzZ9pZ7DX8pTRRTz0nOfxJZ33sz6IbVyZc6
         5TjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784578569; x=1785183369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEIzKGx6nstnSDXiYsrtWuuGIdEs+ij5HpQm4P2etZk=;
        b=d2866SVJs2a0e1lfW2MqZvVhHeHIcHycmtnI65CnmV5ZeaakXFzLdM8aykzl8XCp4r
         FjIgoqKhSid0Ww300wNhKHUVQRbmt5vyhdjyGdMviHWnGpWlKD632Cn+BMeib6C6LWxu
         5VF1OoAfbCwtkrxfDTYj1XkpnLVMkWpe3YoGEjDstsJEFzdcsMULJhwhQKwNyQ66OkgV
         wxxZ3fXTFoneravECaIHMy3fg9WbwXzJbK0co4pRXXXR+ue0ep3EFGwbAXctpImE5eOB
         lQn0zqJHw2zJRBZHBTCL4C56JbOgGfThb8fVfsLLcdX4fLZAht1e0QHTyJG44uJFYEjm
         ip9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784578569; x=1785183369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEIzKGx6nstnSDXiYsrtWuuGIdEs+ij5HpQm4P2etZk=;
        b=qTha7501LCP0yNylHNPp3g+Kj4/5Qjn8dfv+RezhX4vJMUOSzkVd7SkPuLef+DqXRY
         7zxQWivj7lqUtsF41DUEs7HXaONzYd+8vkxBw7KtYNnI0U39HurDWFleE15018Zt411q
         2c6lE8YUHICKG/JaY5nsPVfWPzGqMRYgWAJ1MJrUVT3kqb0o2BA7mDUvFxul1YLAhHL9
         nhjLZsX4UBbWLcG0Syqts1GPqXcsFaJbwkdir5crf1iGmqYZuRFUC1+D/rmuL1P174GK
         pMsVak7+/qGbVAmuov5b7RD1UFtGMid6iRq4GItaeBH9edQX0fn1GSmT2/bkbO/jM614
         Yo3g==
X-Forwarded-Encrypted: i=1; AHgh+Rrl0HECdKg46avpbQ4IJUx7YUdBQvTs6rIx7yqcQslK0RASCuXW1KGzPNI5X09R4b1f8B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0s47thZD3186ULFOc2H0hRojssff922ynzSfDrcVDt2hKxY7t
	BWwc1WoEDBebQ9NU3YDBhWWx8OM3rNAHdfsdhiE7vqBEgl/SweAF7/DmLaDag5lpJQzdzvVgoHb
	xsKf2gGVfJvca2q7gcKvZ21BkD6jT8G0YtX2Zbfdf
X-Gm-Gg: AfdE7cnKkfe4ieMqW97YENQwtFWHc5N9SHGpoX0LA71T66VM34Mh7tz6r4VP+9/IwSQ
	0AikW3K3v4YuWMjKgtY5GPaToLGp+VDc2NZBXuQrKVPHi87G9qrUea3ZC++JrSB8jnzzlLK54Hg
	LFyef9Bi1qddXKhI74HpI4RZd95rPQsRYwNSxPQsESv1CUtLCaDsrCY2eR/0uP6BSCi4W/vp2Hw
	AgU9wIks63o44Z0/4gKLmR9smgsljzJHDfMLMweTEzYYyNGrGkR71NNSqs6VQ==
X-Received: by 2002:a05:6a00:438d:b0:848:68d7:c673 with SMTP id
 d2e1a72fcca58-84c2948848fmr15306792b3a.47.1784578569285; Mon, 20 Jul 2026
 13:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com> <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
In-Reply-To: <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Jul 2026 16:15:56 -0400
X-Gm-Features: AUfX_mw17rEY5xGffzntET0ex7-B1yqGVCACoJsXOFIbYfGKrVihTs1yl3fAaHM
Message-ID: <CAHC9VhR8n_TBPGLGq-Pray+mHrUCdcmqGXi9wTXyeGa2Dc4m4g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: David Windsor <dwindsor@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:27=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> > On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >>
> >> I'm sorry David, now that I'm seeing this function again, especially
> >> with the LSM specific bits extracted into a LSM function, this absolut=
ely
> >> belongs somewhere under security/.  It's only callable from within a
> >> BPF LSM callback and all it does outside of some BPF pointer boilerpla=
te
> >> is call right back into a LSM helper function.
> >>
> >> If the BPF maintainers aren't willing to accept that, then we will all
> >> need to find another way.
> >
> > Where this code lands doesn't matter to me, so I'll stay out of the
> > decision of where it lives.

Yes, you're caught up in some territorial wrangling that goes a fair
bit beyond what you're looking to accomplish.  My apologies for my
half of that, it is an unfortunate part of upstream kernel
development.

> > If this kfunc goes to security/, would we also want to move eg
> > bpf_set_dentry_xattr similarly?
> >
> > I'll roll v6 of this series meanwhile and we'll see what the BPF
> > maintainers say.

Thanks.  Fortunately, it should be easy enough to move the kfunc
around, that's likely one of the smaller changes needed in v6.

> I don't think there was any preference expressed from the BPF side.

Look at the second patch in the v4 patchset, you'll see a preference.

> Logically,
> one cannot be faulted for adding a kfunc to set the xattr for inode in th=
e same
> file where similar kfuncs to set xattr on other FS objects / entities exi=
st.

First off, I can't say that the existing BPF kfuncs intended for use
within a BPF LSM program are in a good location.  Unlike every other
LSM which locates its code under security, the BPF LSM devs have
chosen to locate their associated code all over the place.  Some of
that happened before I was responsible for the LSM framework, and some
of that which has happened afterwards has likely intentionally avoided
traditional LSM review.  Unfortunately, this has muddied things with
respect to what is possible generally in BPF versus what is possible
only when the BPF LSM is enabled; we just recently saw where this was
arguably the root cause of an exploitable vulnerability.

> The question about bpf_set_dentry_xattr is thus valid.

It's a very valid question.  It is my opinion that kfuncs which are
only intended to be called from within BPF LSMs should be located
under security/, just like every other LSM.  If there is a kfunc that
is generally useful from other contexts, that is a different story,
but in the bpf_set_dentry_xattr() case, it is explicitly only useful
for setting 'security.bpf.*' xattrs.

--=20
paul-moore.com
