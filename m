Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAA45BD4B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515127; cv=pass; b=sgRhClt3fjR7Jshtv917EOBIlWObrWvhof5XUznWNUCuvqbZiu+2vA/rgDVZO9U9Gt89a4fORQehuHJUcBC2mRExZBUUmlNkBARLJ+tOvrfkh2Np87lQW5sQpziR88p97H3E9r04YZ2JveGth66vY3dojjilo8G706tmjdCFZVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515127; c=relaxed/simple;
	bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyTHcbL+bkBxIkc9Er3Loaoe0ziSgi3rpiLbzXCLTwDM8Lt43iKdY2LVCfOdILPs6C10GJl7AFGIATHgDbHsO1M7x5jjLnHlmowv+zGJfMazYSd4uikxQM7t+0NKKylg945+r4Ktp+zVtFzZvteKmkdVydDLkOXRRzkz0JcWyXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ8YmyNG; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ8YmyNG"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so4681606d6.3
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 05:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783515123; cv=none;
        d=google.com; s=arc-20260327;
        b=GY7Q3NQLMPngPQ1qNGmvugtOP8is1u/v4HGMjfJoG14r4lMR+A1RBIEv4M/iw+xYUp
         x6atFeKNeKbJfBrzwjbd2buf/voODbUCyeVNYy1eU3cKAPyCXditwf8+LV0g0NQ6bYLa
         dIH+mtbSHMsE6syBX2Fv5kFN/UsnTgW/j/68d+r9wJbcC74fnSwn6vi6D8hghd8zPV97
         v8hB1I2xRXMtfctJTukJ9OkH9exXmj6ZbnYH0jDjXkSWA5KfGyPr0lIQnjEj03FS1bR/
         i/NK5dg4S8w2ixV2SZkUTNbx4EG4AYby60Rsug2j04UB50VCuvwtsXYPFtUCptLgjcyB
         BhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        fh=PcHsleE8AmD4c/hOy8xjPylj0uV4Gaer/DVySy3Hna8=;
        b=VnpiEyJ/m41lM7HJ/iE/QSNlhzkPoDGRiS9b1+TSc+tIiomb19qIf+XaulAH9VZT/1
         prZuw17nNIaSqbmEtDKcwjS410/XzYTI9XQbtQb5mIeX19jU82JC6emuZY+hiVf4j7BX
         yfAuqjslSSbvxoj7S89VpQ/j4gQv8sKBfP/l9TvS9hqqTy+n9/xyMsPVamigXNMD5M1u
         ckqOMvqxICm/vRBQXVDHMt7I4nLCv5W7qEidiiL9IrhKcQNigy3Ui+JtzwfrAZ+4Ro/Y
         B06rdsmqQvfER6LemvxUGxy4p4nktz4WZSkdd+N1+6pKuh8EXTMauGsPDKjc06dF8T/F
         p0pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515123; x=1784119923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=cJ8YmyNGzcUVkugDcbDFSV9hG1XDIYcPXiertRg0HgzcUcju9zF9S1QddQvl1IpWUU
         4k5nyw2V0IVysz1RCrUdJrEDo/h/A2qbnGEkhOL3pMSeZq9aNdhek1gxoF3bPioxNI3d
         ggeFj1wflW8RofhZngweDB2Ewf+1+x6kpdbS6g61gDANdxSQ8inNYw98Euig7Tflxz79
         yJ8j6vynosLrChyjPyPwAlM/tzP8CcmxcP2N9+hHViX91g/XicWPJjt9i8qCxLFKR4ur
         hbNv49Trj68z0qWIkUNyQKuPp7su1TchELfMq/n41YFkTwA8KS5WkUEWYHQo3mp6OZbs
         /R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515123; x=1784119923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=FeqPT73E/TJL+t/attt9g83sSCm0QLVyjPSbY9jcWMznYNtpow/WwMfOWpX2JM++PL
         qskq92kbISpEYQ92QdPc8eema1APyS6FWhpIrgI5pjXBQvYWFA/HJh8rHs3jL+/CTnoN
         QG0Zs+S8U5UvjlwXh6qC44HIzprcsMY/z9pcHBIY3moHRNkkwy/ZcQIpu9owAR8w+kJ0
         I5FdP98OZ8q4S1qHFFb3I3BTVhv/LZWcAIbiLANQ0Os8k5kHucHgJDSNCpt5Ti8rYxhv
         MDtj6Wkz6Ek4u03+B5G+ulXqHJGUnf/dj1aMW0drHQWqBsJAgKdmypNHOhR2CWwZlnQr
         YU0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq59v4OLl9HjKxOjNur5UDKuZTPZ7itz4b8pIL2Di4+bQStwM9ZmhG4jZpYYtTnIKGIXEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6qVTKBCZElY71Yg1nGyEd4fs9kTaWgjJVnt2qs6ukOuOMfpS
	BlIanif2uWFyrep742fYrCocoo0Nu0w3u1eB+XZrDG3AcnS5OyXqVW/ngn0LdPvVZnd2Gocntsb
	hpKJzonxpEBiSjzueTBs091z+VJC7AgI=
X-Gm-Gg: AfdE7cnRkgNayjddMJkIDMxViCnBJZhkYgvWaS6KZjc81HKrZ4IWqM1CowssumjT2+z
	IdJiv/CfUGVN3ifbhkWHl8PaX0NsunV+vkiIN/9SR4UDB6ARd5FTq2FHBcjGNzp1DSaIVmaCxqn
	mWLWSkv4myDZLxLNJQpKmHfy3BP+cSuMahD1g/Rpjodc32/jOoIJZCBQDm7gzy9v1YoKYHDpltX
	wicqHKEbsnvg9ANTQSiwicjJIDnZzqUHmT0rEOUPI/M2V2v1tUC1ypsrFcA7HHG/p3IK/LY0L8R
	czXTpF/ZPpmZxO4R49jDb8NjHkc=
X-Received: by 2002:a05:6214:328c:b0:8fd:6df3:b37a with SMTP id
 6a1803df08f44-8fec361db53mr20328306d6.62.1783515123475; Wed, 08 Jul 2026
 05:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-1-dwindsor@gmail.com> <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
In-Reply-To: <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 8 Jul 2026 08:51:52 -0400
X-Gm-Features: AVVi8CfU37Brxag2yfG62kEk96iHc-RKohKljtHAIy8Sn1Fk6Gh-XV62bqUwhO4
Message-ID: <CAEXv5_j96aUkmSEg4brvk2q-A3SyYzXZ7jyutoXfrc-oDykZYQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
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

On Tue, Jul 7, 2026 at 11:12=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Jul 8, 2026 at 2:09 AM CEST, David Windsor wrote:
> > Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
> > extended attributes. For these LSMs, atomic labeling during inode
> > creation is critical: if the inode becomes accessible before its xattr
> > is set, it is briefly unlabeled, which can disrupt LSMs making policy
> > decisions based on file labels.
> >
> > Existing LSMs solve this by setting xattrs directly in the
> > inode_init_security hook, which runs before the inode becomes
> > accessible. BPF LSM programs currently lack this capability because
> > the hook uses an output parameter (xattr_count) that BPF programs
> > cannot write to, and existing kfuncs like bpf_set_dentry_xattr
> > require a dentry that isn't available until after the inode is
> > accessible.
> >
> > This series introduces the bpf_init_inode_xattr() kfunc, which takes
> > the combined inode_init_security xattr context argument and claims a
> > slot in it via the new security_lsmxattr_add() LSM helper.
> >
>
> There are various CI failures in newly added tests, I don't think any of =
them
> are passing. Please fix before respinning.
>
> https://github.com/kernel-patches/bpf/pull/12730
>
> E.g. both test_init_inode_xattr and test_init_inode_xattr_slot do not hav=
e
> expected results.
>

This is happening because the path "/tmp" in bpf ci isn't mounted on
tmpfs, rather on 9p:

[ 5.813072] VFS: Mounted root (9p filesystem) on device 0:22.
[ 5.924390] vmtest: Mounting tmpfs at /dev/shm
[ 5.971012] vmtest: Mounting tmpfs at /run
[ 6.096271] vmtest: Mounting tmpfs at /mnt

... which doesn't call inode_init_security. Changing the test to
create its file in /dev/shm, which has a real tmpfs, fixes this. We
can update the test to skip on filesystems where the hook doesn't
fire.

I'll wait to gather feedback from Alexei and Paul before sending v6.

> pw-bot: cr
>
> > [...]
