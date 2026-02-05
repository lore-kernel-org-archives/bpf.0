Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C920C00A
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311883; cv=pass; b=YRsfBIVRm1cBfoiCTRkJh8COVKYhaP/d/ERylzlmvmwZSd3i6w2W35Tg03yEbadhOpeaySDANvXJkoAAwzHxpVd7tAQkxRWa++jLpgaMuD2M2GXwkcQaKkoo8SwF8veIAc6k6NF138fE3bBc2oWGakm8sZBTiYqeEzOOeBPukOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311883; c=relaxed/simple;
	bh=4c1kqkyjLe676ojBxo1iOioWKN+q6h1zbdknWAvo6xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgfZD5bUJbGl3udOSsX9M9oSluroJVXmr8g6FrkA/7Q1JXczMRFPxQ5VF3Vxsa/+edtqxWynlbLCoSRkG4+XAbWSbFoi+6f7GCSMushBWgyFfGRH5fazjpKDoWuIUeReyzgWATvbny8W2rveH9GyAG8D1gg2WVUmKl8PL/4oQmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=LMIRvyXB; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="LMIRvyXB"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e2cb21520so1520910e87.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 09:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770311881; cv=none;
        d=google.com; s=arc-20240605;
        b=Suk4nt/vbLjvPSusLxDQ4gyLQLeVkaU87y76W8ukGdEWeSBgZWVBY3NfeEsqzGUXJE
         5wOmf0waOqHGgZGCcXXLURHZvhmJdfJHcBhIAAq4AspVQXxBjiY2b5Zh5f2eYt7Q365Q
         cKuN/BaOnworh5EUKt8u5GJ/4otireJ7a3Bs6GVsmbdB/7+WyuonmT1p0f3kXD8qqO7D
         Qwn4C8X44EP50+0GmqDFaZ5xqnYNqYFpsFyvq5feqN3Jdw51yiqYULnyKptCds9hMzLh
         EbbkyQyjeamx9vPd4NE2VseGJPAkkJMHVgTgyaFfu2EPEGOBsZsMPH05waQaYdHB+1pJ
         3/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qA/hEZpuGKjpxaEvxb4OyM/ccaGMhGqw5+mS4IYoYlU=;
        fh=J8UVOJlGNV+B5TDU+sGEsvNqy1RHJyBeSVjIi/zW87w=;
        b=M8PDk+xGbTLtKe7OCjHRjUFf1QJxes08lCY1M250QBjik1NzopMNfrz5z3DTmIOJxL
         FWd90ePlzhDUrPGF02sA0WOBuHVILfRNB9MUjjNfuq+RNAjz9a0YQ4S8MITqfBggf0li
         JXuy+h4gJwMXWYtxKPzMBTqI0jQi7nOqU6ztD/3ZKfnzEktz7UhU3Q+rr0Mbw3rwTeA7
         Yg59fN/NPjAG2ynuVRXDI2CaAFgtVOhcg/P8ZB6w9Bubmmz25BsUixcVKamJRY866oUb
         XVa63RXljf6kvBbXq+3MfCDYDh4GIbVb0D0Apzp3I+kVk0j61FTEgWadWjWl3mDngHrt
         z/Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770311881; x=1770916681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA/hEZpuGKjpxaEvxb4OyM/ccaGMhGqw5+mS4IYoYlU=;
        b=LMIRvyXBCp7x64wOwtSrXIzJWsqhqrR5VAoRuRioHTFv+QPiWuA5HMAWQ6Zoig5qle
         TFpNrrd5vKOEAsWWB3/0xTCVyJ5fPO1BYkiDPwiFpCgSXHiQB3FS6enljNRYtVHN0T9K
         IXTjaJk/F7A4Zb/PdsZQt1lWPbM4eMyYe9ad0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770311881; x=1770916681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qA/hEZpuGKjpxaEvxb4OyM/ccaGMhGqw5+mS4IYoYlU=;
        b=o2jqpidQaj5XXP/OKmcwL5CTCNLlhMxtMSrerFp7lelRZl4/v49MRaZ9b7ec9x/Qxs
         G1/cLgI0A1/Wi0SO01rTGTvFoqc/qfEANsgw+VezFyJYcLLNqcTJNLHnNAABjsG2NpC5
         NULjsA2UOcmmAU7NjN023EsPmLZEM7RqJEI4Yfjv6NapR+zhLwEigOfBuyfSWLB77Qxt
         9Kq+F2S/kiW0kdudhUJvpPifTtrnSPzoDvnnyEEzYzzm+aBaPx7W76dcWdNDAF8XFB42
         fNxgefe5YmtFXry+cnnUIwTrKrvpDuT//FTFfIaDP4amRtBxi/36iEyx+7/b6ehwIYJn
         5qRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWTTyZpO0NzNv7ViFQlXe+fnd9WhSFYhqX8yL7vdmIaT+EH/1ggdDWh6HUN9nltbUF4nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5J0fHv4eYrtbZaj7k9VBplOAJdacHTirN+otnTjr9quJW9AA
	PM5zkLZQSkmDZZzTb8truCzeKkfnjh4zTf5Bhjbx0ZKbN+Yr30Oiv2WUTgsDD2cWxU0+8/hhOBr
	A1xx3sBdUA72GaIeCxy1plUpQAqSfkozJlACx1Ibyvw==
X-Gm-Gg: AZuq6aJs+JPlxWW14JsMo1eRk9+1W7gcBOAkLlNy4ly5/eekJoi8rohGSf66gI1ZylF
	7o7FY87u6b0g8I0EljnVam8s66C+5Uj+k4fW1GtbAPPjrQXoQ+M4McgKieg0E7fNIpwPTYRhmMA
	R26WyTfhG4MCpC18E+Dmy0axo5WRsQk2nVQlVDUJToWAWAteSrA5i7zQVGXcNFUoSUJy4Xt4gPN
	XXiyKVY6pFq0VEAQ2Grp6i3Em7+7xLUQwQ2FBbLk8vZYLfAIc9PQcJC/OHa4pXr+tsJQ2yFI0xq
	j4GbY6YZLWlLPXZlWJJUnIlELw==
X-Received: by 2002:a05:6512:4001:b0:59e:479:917c with SMTP id
 2adb3069b0e04-59e38c359b3mr2629269e87.39.1770311881298; Thu, 05 Feb 2026
 09:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com> <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com>
In-Reply-To: <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 18:17:49 +0100
X-Gm-Features: AZwV_QgC2HbXVe8BGI_t1Hbec_qoVnGkULZZYVElG6i057xj0OEUbx9EQoStGYw
Message-ID: <CAJqdLrpOGmCC2TpUGisBYQCHpjd6L+LQ40UiuNqWS3pOHFkcFQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	aleksandr.mikhalitsyn@futurfusion.io, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Do., 5. Feb. 2026 um 17:43 Uhr schrieb Alexei Starovoitov
<alexei.starovoitov@gmail.com>:
>
> On Thu, Feb 5, 2026 at 3:27=E2=80=AFAM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> > >
> > > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > > index 005ea3a2c..c350857b2 100644
> > >
> > > [ ... ]
> > >
> > > > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type =
=3D {
> > > >       .init_fs_context =3D bpf_init_fs_context,
> > > >       .parameters     =3D bpf_fs_parameters,
> > > >       .kill_sb        =3D bpf_kill_super,
> > > > -     .fs_flags       =3D FS_USERNS_MOUNT,
> > > > +     .fs_flags       =3D FS_USERNS_DELEGATABLE,
> > > >  };
> > >
> > > FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the k=
ernel
> > > tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is de=
fined
> > > (at line 2268), not FS_USERNS_DELEGATABLE.
> > >
> > > The commit message states this flag was "recently introduced", but it=
 is not
> > > present in this codebase. Will this cause a build failure due to an u=
ndefined
> > > identifier?
> >
> > Yeah, this should be applied on top of
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-7.0.misc&id=3D269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > in vfs/vfs-7.0.misc I think.

Hi Alexei,

>
> I think it's better to go via bpf-next this after the merge window
> to make sure it goes through full CI run with AI review, etc.

Yeah, thanks to Daniel's suggestion it went through full CI already.
Please, see https://github.com/kernel-patches/bpf/pull/10970#issue-39014101=
45

Kind regards,
Alex
