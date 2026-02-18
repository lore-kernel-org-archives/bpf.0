Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115CC3446BC
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441648; cv=pass; b=G5diX75FQsekPI/UAzOhGjf47SECcNko3XbRuUjdaacLIKNBwsTVAsrFGxQfnbDt2igCktqEleS3tyvSNmyxsU+lRgXv3QAG9xzuPxEttFyLAQKT5CkLApW1hyr2Y/Ea5PjRjXrIamaYeUc6rQ8J+S4MZ+/KrlXIawLsw1nbeTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441648; c=relaxed/simple;
	bh=GjyKToIJ3aP58GPO4xfYSsw9QHC04GARLSt+I1kBb6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFQjKBC7mU0n7u73urwtFeokIV1TkapvdnfzrsPqRpfCRin4L0WuN2oDIFmM/BlSeD62wxPAEm6bO4dsEcZwcyoT258lHSayCMn/qWCEbM4QfseuPm2NYytT7G/amScCUjL6H5IiUpzk/F48zATYezIk1pP0YzmPlUZGXfeK6FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T731vQRv; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T731vQRv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35480b0827bso129789a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 11:07:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441646; cv=none;
        d=google.com; s=arc-20240605;
        b=fqiH04QtDFeDc9DAFWHgxqknAv+UH04KAxYQ729IGI5CH3qyt4zQNi4OwK8jnsWPKy
         9X5EvJ+ChlxDWyyeLP+crRlB9L4pD7P/w8Smfclbu0b5Lqte2ye/0KMGWr7OiUgRNf9r
         s9wGiZt4bDfzkER80Lyxi6lwtIbTdyN4+8o4n51LeY7//8Ysg5I+FOmlnHtoqzEGJWbp
         FIKa18vGpMNkqeWLQo6vawX/MVOd/AJ0DoPGDa7gHmKQFS3kgjxQzsTuz7mCWYhpEkJw
         9bCo1SgODUSnmoZ9dQuxLt4nr94FjGt2YF9Z9gTeeHVsj+DBpVvXvArv5b9dqzpLz6wd
         7amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KkbMCDJilr7JAmNccRIIBiFSH9+s3nrl/Wr87OlM64I=;
        fh=UOL/Q1Y0tNTrQLP5EgFyY93sUDLWGhhHvl5t+tjW+cs=;
        b=Hyc45WkyCr523jQ7uhB0f5nusfHAcxzsg4rZeidhReoiS8A0fEw5Yv/xOBTnvSZz1o
         R6iH/eY/mCZd9eLLplR8R+6x16H6Dt37iJVxqUmwxk9u63f5qUQ3JgB2i2UPwMidipXr
         56V5Hon8a47eV+8+h7P3+s7+plwlawL1z9ZFBXJDKDI54UM0oTd8S1z8kEF1KH7OJnr5
         whEQWL7i5PmLOJK3hWQfjii06/TbN6fl8VdVo2l0l4Jv8UC1cszSWkMarlxfquqw58cs
         BMcvGKKaqzxzSP2o9UNCI4VilEzLOSlQyITpoNwC9/2yv6EfJNoZPBque087R3uhOkni
         9OoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771441646; x=1772046446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkbMCDJilr7JAmNccRIIBiFSH9+s3nrl/Wr87OlM64I=;
        b=T731vQRvRlRzqf7vhGSkr8Go1vrpxSN2MqU2HggdsDOB/DQ/x8w6NEGV6hFHsDpbdW
         q+JDYcGV0t3zf7T97FnUysi/I+melj4sZUY13s0s8KnUC7C7pGScbPE2kGNBkto0bUF7
         VUUJ+dEef04cU6vi3yS1VHeG6waBeTE69Jx+JMp3yB9mm3lcyZhTa2niFNuXAbw8GRvn
         ndHAylsGxFWYzeHdJoXUJzWo8HomNZziqmaQkHtbQPY8pGnB8DMjBhhhnCIfkzVLKXoi
         pTbtmD+FZtFAeDkzQuaPaWuwADYnHfFNcRYz+qPJqsRpoH5hi7sMPxWOX1rO3HuYDVNs
         eQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441646; x=1772046446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KkbMCDJilr7JAmNccRIIBiFSH9+s3nrl/Wr87OlM64I=;
        b=BK3RBoHPVOFssFjLnaUj4xZWoDqUoF+pEJo3IEjG0w4ZZNVdSiRSryMQBP6DFfCq51
         Whib/jqIaI+9959iMjHCPhcUdAK+WMJv91hVFLd085AKNh32BfzvTVozSQRWz/k/NGxr
         Cqk+YWgtr4GgjssFzNtr93uovbvpcZ81qKlyRKrIBHUMxnOFIddVtvP7kfJbwQASmA7R
         b4NyXOV6v0dcwuTQ6nw4aBjcAzY/aXISqp3efhOa6ptH7WJ8IaYq3M6yDhBhcfqr2JLE
         BMn6ShdhBhbSHtZ1B4iCKnjak2PvEzVW2wksg08eLnWTO74OdU8wzOiufgFhF7P/4iGR
         /DLA==
X-Forwarded-Encrypted: i=1; AJvYcCU39sirBQW+XP1Cw/AYg3ktPAtiiRUm/yWqlACYEnNZLoEWR6utMWoVQ+8oYtdB0qj0Wgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLBIWMiiBQvo3BE0YVLvE/XOl4V134ItBfyEa5tSM1qdzVtmz
	7OwejJ41gfTyyxiRndSQQUOUgw8p0V/tRXzdp1UHFdWqPcbMWLri6FWgDVWHYPku5Ty8fAFuzh9
	ZJ3xA6HavEHp5lZxQroFuTUNjzpTK7XY=
X-Gm-Gg: AZuq6aJFYAcvrXKWQaCkdzeggadLXW/sqaSIqhKFeySK2BiiXQPeKUsS6+dbOzcd6wl
	mCM9R3Zmo75uC3+Zc7fVVRvP0+8Is2pXatXs9DuXBJyrdiYIYLSEZzyYSqQ8Wr0gv+/GoBl5jXS
	kGIC6LfBKhxdHeGOdZnu3KySoSleYrzQUNNXtwQ+I7DZ7YPP8eGs4z1Rkh/jGSrfKzWG96LYerw
	xjgFyME9MFv9SZesyzbVPP6ckQ6XERa9R4XkUFxAiu71JoH0lHXPwLqrKvKfHwQrAa8LdTZMDLj
	86nr7ZpsOUQpS4i6aOwsog==
X-Received: by 2002:a17:90b:17cd:b0:354:c40c:7010 with SMTP id
 98e67ed59e1d1-35888d14f36mr2293850a91.11.1771441646439; Wed, 18 Feb 2026
 11:07:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212152013.17351-1-varunrmallya@gmail.com>
 <20260212152013.17351-2-varunrmallya@gmail.com> <82d31503-24d8-45b8-b1dd-2cb35bd28509@linux.dev>
 <aY9dxEBCvurRfzJU@roxy> <a1655fee-4ed8-41bd-ab48-cf22db76c586@linux.dev>
In-Reply-To: <a1655fee-4ed8-41bd-ab48-cf22db76c586@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Feb 2026 11:07:14 -0800
X-Gm-Features: AaiRm52Y50zGkneOe5NQ-RUZBE-5Rig-BDfID3rUwzm9WG3F83jOiv4DD9WeD2E
Message-ID: <CAEf4BzZZpsuDZNCLky53WT0iLy7tLV06TWo02pnrVxsRX74o8w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/1] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Varun R Mallya <varunrmallya@gmail.com>, andrii@kernel.org, alan.maguire@oracle.com, 
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 9:25=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 2/13/26 9:22 AM, Varun R Mallya wrote:
> > On Thu, Feb 12, 2026 at 04:06:22PM -0800, Yonghong Song wrote:
> >>
> >> On 2/12/26 7:20 AM, Varun R Mallya wrote:
> >>> This patch modifies libbpf to automatically "upgrade" standard
> >>> SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
> >>> infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
> >>> supports it, making them compatible with BPF tokens.
> >>>
> >>> To maintain backward compatibility and handle rare cases where singul=
ar
> >>> uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.sin=
gle")
> >>> section types are introduced. These force libbpf to use the legacy
> >>> perf_event_open() attachment path.
> >> Maybe you can have bpf programs for both uprobe/uretprobe
> >> and uprobe.multi/uretprobe.multi?
> >>
> >> You can add "?" before the section name (e.g., SEC("?uprobe") so you c=
an
> >> selectively enable those programs before loading. This one if one choi=
ce
> >> e.g. uprobe/uretprobe is not working, you can then try
> >> uprobe.multi/uretprobe.multi.
> > This is a good idea, but isn't making the upgradation built-in a better
> > choice ?
> > This way, anyone writing the program does not have to rewrite
> > the same thing twice, keeping their programs pretty clean. This also
> > moves the upgradation logic (which is probably going to be repeated mul=
tiple times)
> > into the library which makes it easier for anyone to have something BPF
> > Token compatible without having to write all this extra logic. Since "u=
probe.multi"
> > is compatible with "uprobe", I don't think anything will break as well.
> > (The current breakages in the selftests are due to the patch being in
> > nascent stages and I'll fix it after I get some feedback on my
> > questions.)
>
> I still feel this is a hack, esp. for libbpf. The libbpf provides various
> APIs as the building block. Automatic upgrading inside libbpf does not
> sound right. These upgrading thing should happen in applications.
>
>  From bpf program side, you can have progs for both uprobe and uprobe_mul=
ti.
> You can have static function which can be used for both uprobe and uprobe=
_multi.
> It should not be hard. Looks at bpf selftest, there are quite some progra=
ms
> with prefix "?" which gives application a choice whether it should be
> enabled or not during to kernel probing or other things.
>

Yeah, you can definitely handle this without needing to duplicate the
logic in BPF code, but the idea here is to make uprobe work
transparently inside user namespaced containers (assuming BPF token
was provided), without having to explicitly accommodate this as a
special mode.

So while it can be seen as a bit of a hack, in practice whether you
use uprobe or uprobe.multi doesn't really matter (they have equivalent
features from BPF/kernel POV), but being able to just use
SEC("uprobe") is great because you don't have to worry about old
kernels not supporting uprobe.multi, plus you get automatic BPF token
compatibility.

This is a bit harder for kprobes because singular kprobe can be
installed at an offset, while kprobe.multi only support offset zero.
But even with kprobe, I think it's worth trying to transparently make
them BPF token-aware using a similar approach.
