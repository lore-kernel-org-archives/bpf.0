Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA28272816
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845212; cv=pass; b=jA7d5h6RBlIWVHRjEUJE+yiyhchAz9d7Q+R5K7wutuKX/eUaThkpAVbmXYfDUE4vNe4I+Ik9b6ZBtDlpCPp+TQ41iddEYScZVoFue6ogKV/syw+ZDjNT+H8jHNA459XdiTgG3CobOZ4BNFMdzTdPW07nxfStaIIT/6BRzlTsi2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845212; c=relaxed/simple;
	bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oagPiu/M8JJzhHGRma+PV2v45T1fNxXfnq6PXyf8AACB0pzum4dwzFPP5oZDsNDk49Nnx/kAjUNjukI3CWDyw2kOk4OkfP9yPQaCitOrusikFsfaB9zKEZ4P0ixR7V0L8D/ZiHIjpYimoyQFo198NMemIu0uYzcJyiweryqTvzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQSgW7XY; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQSgW7XY"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ea93125ad1so40489646d6.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782845210; cv=none;
        d=google.com; s=arc-20260327;
        b=D/q4QzB6gnhZSBwxiSxxb9/0TZmckSC9Gs28uJElcnyhZffJ3VsZLDseoTFB4e28O4
         o/Oa/HI9t6vxW2iXLEKucD7+SyfGURFh/IdIOUMklYxSUNygKn/rkK/OlzPE0YH7uzkP
         rndAypGliolAq3wVZxLk2sX0QKE8iTjVFjG3XGZKuj7l8pK0ppsDPrXwHrvG2zIU6lz0
         4XEHGYNH+8QZRhgfZEJ0AkJgrc+id4Jch+WqdZKYAJIPhwGzOnA+kh0s9RmaoJcq1mnC
         6ThsuSGO0Y2JKXFvLY2X9ZqC7QJ/Vi7JzPKoEfjcfYD//IouZqgSTTbcXctF+tnNB2rO
         H5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        fh=8OGR4TP8XEuCVLyyUs9UfxIPqimXGgg1H+poMhp7tMo=;
        b=MgV0yd2I4fMI4kF5AQlgjlrnueXgdJzMX2jnE8kHVVacOWBQkRERjmtt9BDsTYym4G
         +vim2mH2FE5NkdZDt7Pc67ChqA3iYbag2Wmuut/noH1XtSiktcY8gUKaN2wLDsG8NTUH
         cJAT0THloblFwCa0dI5YqFzVB7AdDdOkAds449QJ++HRgrgFpPmNrLFeE5HOf2UtjWia
         EqphJa95IIOmF5X2pfGIxSZhTWMxt7xShV8s2YX+6nJq9owD++5QJie0384nBRzbClt9
         1xno1WVQfnLvKKLeVPqk3GI4V4YO17e25n4c2WArALXE9XkeJ1Q/mPAr2SDkzcwwvvK6
         iMYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782845210; x=1783450010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=EQSgW7XYwFqpR2UhR5oIjGjz1p7Sl5z7prkaHtU62QYm16o5fwYNMZbZzXDw4N1o7w
         TjaTc8/oiqjtm0zKD8i/CcS95pH2dm+43MADe2rn9aMf1hKPGLdSdl+rh7nEvSKdwdWb
         QjR+GW8xwXjKE83wXgRxXBKZFIbpxBvEorTFKDTnaw6FQqAGR1E6nY0qU6hw6SonOJ6f
         UnNgIa6B4mckZ2hxw1SIudwaouFYge5A1ubJndzfYxye9NPihpkUAmXXjBYL0RLjqY1x
         hVUSvSmtURF36OOyxm9jT4L44uwrOo02x0k956HPazkIOlQs3pQRuCDykMIY8f+Jh/HA
         PW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845210; x=1783450010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mr0mxcymU+YTx8PbSVH8xKSeGb4CtbjDq3BsjMlcFI=;
        b=HwiCiZv+1slsVKm29z572y9+eN+h1QtNckF/nH+RcUf1pNWh6+4D1wRLsYAElsAXfa
         31ouGE1BAUBYvsUas49YdJ7DEeXNDTN1+B6bWNmD7FpF3qdNRs7pShB76fwgFVK4s6bu
         Tym+EK0EFSkHl2WGmlagVSGBNo7c+L/qck64risBsMsgdkrGzgqqStIzu5SQzYudhsad
         YcOizoafzP/KTI06JpY0I8e2Z63/yS9bqqNaWnAYGNlSuYJruJyFmYNrc4QYJOIRiyaF
         OdBnGsNjBvAKpnCgeBm77zi63Um1X927ZFBeFMnU9mnlwG5tzesQCytvTtiNTFTvJ+Ln
         B/Ew==
X-Gm-Message-State: AOJu0YxE5rukbOkyBSGK1K/Q4rysejb47FugBJLNdsqSpQb7XyL7N/Ux
	nF/N5bB4vGjVSpYB5dy7H8eKhEMCDLgGWF/Yu0zh9Oa+zY3u8dD8h8Y3krJSoYQ41ZJqIorLMMK
	gHCt8yyayKCwqhfnKUjh4sJq+pJa963s=
X-Gm-Gg: AfdE7cnxOaEc99m5ZPmABXtR2QsuHviT/Ee9Knb6XO33Nyqct0x+mCVnXKK5/0fKwIf
	d7rfE1dsLuDJTv2d7Y12dx8UKssuKp/52+/+AdYbDNBwLOSMZcqYIUcAFffa+dqIaJKX1mhzag4
	uJ82z6Ao2iiglUM5g4UxQ7LmGx4jiQcu9uPHF/5SXiPrwph41zvtQTnFFsAb2weegr3uhXAwZ05
	9aEcGlYJV84J+LbQwdw3C3AWmGc/+Fqs0BzlWWRVvT714t8GEyO/vugSD9Tk5SY9FPBggdCRo4h
	OMHfDtYZrsBTOkOgXhdVGX5ZxLHDJ06s70vSEA==
X-Received: by 2002:a05:6214:4d01:b0:8f0:b08d:1327 with SMTP id
 6a1803df08f44-8f1bab7325amr66906576d6.20.1782845210237; Tue, 30 Jun 2026
 11:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 30 Jun 2026 14:46:38 -0400
X-Gm-Features: AVVi8CeaiheJ3F5i-jO4LvtVLGlRB5U5ReoDcpDUEtFteA-6-xXjOCWxSS0LCkE
Message-ID: <CAEXv5_jCoYbs63RRukH44CMCxiOFzvWWraBOunKrgTVw+inUPg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
<snip>
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there. Anything that's just bpf infra
> specific can go to security/bpf/kfuncs.c instead. But anyway, it's a bpf
> specific helper so it's the bpf maintainer's call.

After Alexei's requested changes removing the attach-time checks,
there's really not much left to go in an LSM-specific kfuncs file. The
bpf infra plumbing for registering the kfunc and bpf_xattrs_used()
seem to be the only LSM-specific bits aside from the kfunc.

I am willing to put this code anywhere. I've tried to CC all involved
in all 3 patches, even though there's some split in concerns.
