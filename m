Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C31C6A3
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767212; cv=none; b=jDB8+kefAkqxBLyJZrdiToi5J4FXsMdL9cxvdJ9MKjqYqado8NO2+ca1RbimEDCK1azCpckpVsi13pNbk9JxH8IyhQ+c5mkSJl2uiZs3/U4FDkmcZpVqDbL9ZNRwRB0Tj+bOKODLuQROkIX536OPIb0aO3VEcmzim1zYRlW8yu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767212; c=relaxed/simple;
	bh=/NhOBk+BJoj/dD+kh3pmPoEgiLVTeZy+6SJZ2iMoHiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVZEKd/y2NlpPPbLHFSMg3u3d7aVxB3FsK7/AJovaCodeLQ9aVT4HPoPuQSycfn+fpwyxGo4pu+n0PTCY4uppQTcQeeS8A6DxbJrIiseOgzRRCYEKJqXWQ3Y2asS3RSbQMUNob2JSx3XTNlAnXuWdn0aAmNEvHuas14/JnENFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=S0/jx9UK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="S0/jx9UK"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6095dfcb461so3011727b3.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709767210; x=1710372010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAVh4Azn0AZ3/Zc+NYDbaDtsTpY96I/NAS0abMjYKus=;
        b=S0/jx9UKuAHeKPuMEygaGpvN2a+hq16AoDPqzlCvs02W1in9KDjQ/W3SqGU/lHTtA2
         J2p6299twgcETv96iqcjSCUw6/YaCpPWQYHehaOpAyVBrWmn9dlQb8xK0ngU0Js5AG8I
         oKh52Qafnm9o0I54Wv8Pe2r9Jq4p+HjrychSKGy8PZTDFDVt2AtBA/F3b19Oa1RnWxLC
         zrLea+sXXXFLes+r9FbEh6TPyw65Ja/thvi075fLcu/BCMkJpJMw4jISL7rEWG6kfA1d
         iMpFkgm/AqYfnMeailGsW9cW3i9HF8jr00vybtzBwDacE8UpkUE12TgPrnCZNPsLkjcM
         kBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767210; x=1710372010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAVh4Azn0AZ3/Zc+NYDbaDtsTpY96I/NAS0abMjYKus=;
        b=ja5wnqN6dyTcVxDwYQBHZrBnf6VNb8L6RL6yMEFy9E5sfHVm0ZAU0vQYrTFAktWzvL
         KQjSgrl1wC2U9arECXWbyayPRnPDqFFTWsEiQ/7QssxvHi35BN2fXl+JlR0qPkCxI5yg
         x5h7ooFMS9akX5a4brYwCvnIvE0dDfttm29O9MpoaRVp89WvSYDmr1PC79j+9SdtFzCw
         MZy6H2GPI9uf9mIIAy/rcLih8zhPNt059GTtKy5LdJkSCtqIlDCACyn+MQ620Ex93EeI
         j59shuzhUKNIyWHosqekU1APGo23PJDH1S4eU7FDZkwkdIpNIpSKPw1DTJolw8beytHe
         FTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4cK0rFl+12XnrV6KLUslAebikKjY+8v2PTpSd4Jdd94QHyjYlSWBZo6B46bOYuX4lTG/TVjgmGRvoDAHqSGb/JP/f
X-Gm-Message-State: AOJu0Yz+RXKXylubOHOFxi8sUvehbBOJDmAfQ3jR1N9pEeX+W8yGSME0
	jtk7/7sHPZTBa2VKN7/EbMiY87TVmYa567rTw5RshDjrbZIkffhGfOp7NKDLf7pjxQRQ3SnAvxD
	3c/wMsDqdU2S7QrfflRxfr9a6Q1VEHzRZGiGZ
X-Google-Smtp-Source: AGHT+IHqIPEt5dLH1JOGREq06xglvd53+wnwcqhC9A182ebQZNXP0KoYczMYTK70sZhARFifGkUfc0JmbebVUBBEG1s=
X-Received: by 2002:a05:6902:250d:b0:dcd:5187:a032 with SMTP id
 dt13-20020a056902250d00b00dcd5187a032mr15700825ybb.43.1709767210273; Wed, 06
 Mar 2024 15:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-15-jhs@mojatatu.com>
 <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev> <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
 <f88b5f65-957e-4b5d-8959-d16e79372658@linux.dev> <CAM0EoMk=igKT5ZEwcfdQqP6O3u8tO7VOpkNsWE1b92ia2eZVpw@mail.gmail.com>
 <496c78b7-4e16-42eb-a2f4-99472cd764fd@linux.dev> <CAM0EoMmB0s5WzZ-CgGWBF9YdaWi7O0tHEj+C8zuryGhKz7+FpA@mail.gmail.com>
 <7aaeee73-4197-4ea8-834a-2265ef078bab@linux.dev> <CAM0EoMnkJpBnD5G3CfWnGkzE1cQKDp_mz02BW+aHK4rbTnOQCQ@mail.gmail.com>
 <c5f75c8d-847f-4f9e-81d6-8297e8ca48b4@linux.dev>
In-Reply-To: <c5f75c8d-847f-4f9e-81d6-8297e8ca48b4@linux.dev>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 6 Mar 2024 18:19:58 -0500
Message-ID: <CAM0EoMn_c7Kbakrk08poLQOX9z9Pwv=D4AOoftuUJF4FcMRYJg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 14/15] p4tc: add set of P4TC table kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:21=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 3/6/24 12:22 PM, Jamal Hadi Salim wrote:
> >> I think my question was, who can use the act_bpf_kern object when all =
tc bpf
> >> prog is unloaded? If no one can use it, it should as well be cleaned u=
p when the
> >> bpf prog is unloaded.
> >>
> >> or the kernel p4 pipeline can use the act_bpf_kern object even when th=
ere is no
> >> bpf prog loaded?
>
> [ ... ]
>
> >>> I am looking at the conntrack code and i dont see how they release
> >>> entries from the cotrack table when the bpf prog goes away.
>
> [ ... ]
>
> > I asked earlier about conntrack (where we took the inspiration from):
> > How is what we are doing different from contrack? If you can help me
> > understand that i am more than willing to make the change.
> > Conntrack entries can be added via the kfunc(same for us). Contrack
> > entries can also be added from the control plane and can be found by
> > ebpf lookups(same for us). They can be deleted by the control plane,
> > timers, entry evictions to make space for new entries, etc (same for
> > us). Not sure if they can be deleted by ebpf side (we can). Perusing
> > the conntrack code, I could not find anything  that indicated that
> > entries created from ebpf are deleted when the ebpf program goes away.
> >
> > To re-emphasize: Maybe there's something subtle i am missing that we
> > are not doing that conntrack is doing?
> > Conntrack does one small thing we dont: It allocs and returns to ebpf
> > the memory for insertion. I dont see that as particularly useful for
> > our case (and more importantly how that results in the entries being
> > deleted when the ebpf prog goes away)
>
> afaik, the conntrack kfunc inserts "struct nf_conn" that can also be used=
 by
> other kernel parts, so it is reasonable to go through the kernel existing
> eviction logic. It is why my earlier question on "is the act_bpf_kern obj=
ect
> only useful for the bpf prog alone but not other kernel parts". From read=
ing
> patch 14, it seems to be only usable by bpf prog. When all bpf program is
> unloaded, who will still read it and do something useful? If I mis-unders=
tood
> it, this will be useful to capture in the commit message to explain how i=
t could
> be used by other kernel parts without bpf prog running.

Ok, I think i may have got the issue. Sigh. I didnt do a good job
explaining p4tc_table_entry_act_bpf_kern which has been the crux of
our back and forth. Sorry I know you said this several times and i was
busy describing things around it instead.
 A multiple of these structure p4tc_table_entry_act_bpf_kern are
preallocated(to match the P4 architecture, patch #9 describes some of
the subtleties involved) by the p4tc control plane and put in a kernel
pool. Their purpose is to hold the action parameters that are returned
to ebpf when there is a successful table lookup.  When the table entry
is deleted the act_bpf_kern is recycled to a pool to be reused for the
next table entry. The only time the pool memory is released is when
the pipeline is deleted. So it is not allocated via the kfunc at all.

I am not sure if that helps, if it does and you feel it should go in
the commit message we can do that. If not, please a little more
patience with me..

cheers,
jamal
