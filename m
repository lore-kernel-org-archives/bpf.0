Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281792E974D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472954; cv=pass; b=FdVf2yIYJ2yEirG/DjIULO5KfrZjnCJY7aSGgaHYfiZ+brpmnLFrzhlFE/n2JMwa0OVJs/6X2ZFJ1TZBjfqQx7NmqWOAZOyvc4cfhWswLA7REZJadM6C7dzSw+13KKKlgjAig6qRfqs+iKMQlbt78B7l+n7//NZM7w50dEOnqxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472954; c=relaxed/simple;
	bh=yqtwijJFAq2Vipx/7BM0rX+3bcBaOGswp9DDHJJf19A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVrtxHbLwjnJfRnFM2oe11d9iekzBiJweuvVYDu/NoJpBjCRYmA7inZtoaeEsj56DhQQdWeeEHiJN97XmzlQf8EqusybNQ7VzYZT8rgwMReDRCWvUzWBiqvJTi0WKQB6Hw5SkaOxZftyBvwAze+/TBGg6f9u4xDnmhWHSkcp7ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa3n5j/D; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa3n5j/D"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-650182d19e0so4221789d50.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 03:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775472952; cv=none;
        d=google.com; s=arc-20240605;
        b=bzwCFRpEUWtlxgCltF/P0x4jVSOFhjK7IWihzCk2SfuDrWakY2fApdQVfFetyo2YB0
         36B/yjcF2mJBR7wjUnbfzJmBpplhZALVoK23eq4rjWqsGD8Am4acWr67SC+OvjFl1rJf
         5ruISzpysALEPyXLf+b5WlsReErBXxoAZRxuZUwbjfhloHJBa9hXy5kId4A29E90IlNg
         qICmYIeQ0vMwyVyOXC/WT9ZEYqOGAztMr9IWPEvYa3kx2XKOuXyKoqlj+V+Z3LAm0El5
         At4GCh4qruLOp7Lol2SabYTrsoIs9oRtGeoymED8Wih6bhaNG465IxO2UUbl6NOzNkWC
         nqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7uq6NOmuMF5oFq3KCbCddyHNt0qGPgVd9ZLN7F8nbAE=;
        fh=+bAxkcW31Gvml0FwRoAOcqQ7NdqgX0i2PFFwbo0HhXQ=;
        b=S4bYBLWlfI2ViQNCUjbDnCfSrWKMUp0/OPElEDBBQyi0dqhmR24uL10Dxvcn16o2k4
         L7itFYA0JIVNzVS0k+eTlY9+Na7ZPfZwFlTF8NNIIzXt9Q3PTIe98oRMr80fNVeRusz6
         v6wffE5+SfvafoE5DjHmPemxjihL+Im4JUD79dpXOFwhuYSiCzLk2y2k+UX7T2tdLEO4
         t3kWYs2KHTi8YmCH3mdezUXD0PeIS0iHE58nJupWceJg/iyI2x6+eNKdcqpf73PpfJQn
         853dnR5wML6X0NWLq9GEZ/yf1BuXuLcZy2opsSjKnxgM7tr/+v5cqmETRzyiQpHcY9Wl
         ur+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775472952; x=1776077752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uq6NOmuMF5oFq3KCbCddyHNt0qGPgVd9ZLN7F8nbAE=;
        b=aa3n5j/D15RKLLEqR7to+GtxRAGugLHhde/cNcdw2n7LGYBdwRAHAjMAdRqbnbDP1i
         7DF98zVf+wT3iy5LrysjBm1on0an7JDysMAtLEx2NIwI3yCnB+WuUhs6FdaZ5uELrOV5
         qWqB0KU+Fos4hz7W/17uTAlBctEZRSrWIXVE+qKC5arkCQJaZ58MdOE0D5utVNMLnswe
         c7GnIcoiDSYaB/oETBk1FF4k48pnNtESF6ogwUak4rnEj70GC+ipG+ej6rNVgyicuKkF
         alhzu23eVnFcSIz5NzqNDX25nUxBrETs9OaH1qxN9E5D00/gUgGDQ5nr8qFBeAXEj9hh
         SMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775472952; x=1776077752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uq6NOmuMF5oFq3KCbCddyHNt0qGPgVd9ZLN7F8nbAE=;
        b=j0TYA4Q3x5fcT/yUqIsuSrjsEzJthfPfY0KvIwP9RNNlUulZxYiiT7c5mHQQumZLOP
         ENWudm8DUj62z5QKQJuy3GjYYLFtajhM4RUDheIlyoGyk84OSt4EImWRmYt7FVLLitmj
         CbVd3UlTeyvq5DitUWAZlcX5Sly/zMxGw7RGX0IDkliUBOSRWBAfoRjiVpHIG+1IEVfb
         MoPYGlkVKZ1lm10yaw3G35EgtI693SnY/TC56sRu9gZHtxkU2BNxHVC6fNB4KvZKNdX/
         TrUTZNQ+xSFclnUfSQAV8TXbBsnhhJ9iVE4u1phHXPt5zUS8PBHRhKE6KP5f1qu9PvLr
         HP1w==
X-Forwarded-Encrypted: i=1; AJvYcCUfER07PNNBi5zgPcB4UM+DJurCBm4E5SWmBlxGZQtwMWfwnq/hq8ZrqtD/SNLt/kE52TM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TpGynR7BZBbKZE64sgaNrMdmVEDK1EsEtaVdM+aTJ78nvx8H
	VsbwUhGLEQOJxZl/LPuC0o+wpuzx7kbYWSHiPh98rRc2g3eDwzf0Pr9+HwG3Uk+D6zP0HwRPBfG
	7yv3QpiJJY5tHUsaEQML7WfAQvluKwGM=
X-Gm-Gg: AeBDiet7Ah3qxJYzfNadeTNpDZgPri93ekZRxzALc9jxea7uGjIjc7sJ61abTfuEeAt
	lYRgF+0gUOcf3iCCrURSbtMbSiMcmKibRbv0xz+Y2VLiTID1vBM1NjD3k7P9lMUMcLAcyTMK31s
	vv0Gx6lRR1OESaw3EyOD1CjpFe1ySCH1JSYb8vvFpgLtayqXuWWVTTVbg76dGh+ZAuqmNUtqMkr
	kzdkB7vYHjMuOVl1i1Y4EAHdUOj+F9nz5jeuV7RE/ez3LYXE8lkewpZBmQmTKV8dGhAzluvgXEQ
	G5+1nSDlNlfeVM+87m0XQGv+etwiag9UGblAM3w=
X-Received: by 2002:a05:690e:14cf:b0:650:17fe:1a9c with SMTP id
 956f58d0204a3-650487755d2mr11770998d50.33.1775472952117; Mon, 06 Apr 2026
 03:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 6 Apr 2026 18:55:10 +0800
X-Gm-Features: AQROBzAue1hvnBCCEMF_NUELA-CKaaUqDrVovMjW_KAS9zf6eAY3_xH0-Hp_7YU
Message-ID: <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 12:07=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Hi Yafang,
>
> On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Livepatching allows for rapid experimentation with new kernel features
> > without interrupting production workloads. However, static livepatches =
lack
> > the flexibility required to tune features based on task-specific attrib=
utes,
> > such as cgroup membership, which is critical in multi-tenant k8s
> > environments. Furthermore, hardcoding logic into a livepatch prevents
> > dynamic adjustments based on the runtime environment.
> >
> > To address this, we propose a hybrid approach using BPF. Our production=
 use
> > case involves:
> >
> > 1. Deploying a Livepatch function to serve as a stable BPF hook.
> >
> > 2. Utilizing bpf_override_return() to dynamically modify the return val=
ue
> >    of that hook based on the current task's context.
>
> Could you please provide a specific use case that can benefit from this?
> AFAICT, livepatch is more flexible but risky (may cause crash); while
> BPF is safe, but less flexible. The combination you are proposing seems
> to get the worse of the two sides. Maybe it can indeed get the benefit of
> both sides in some cases, but I cannot think of such examples.
>

Here is an example we recently deployed on our production servers:

  https://lore.kernel.org/bpf/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqge=
o4C0iA@mail.gmail.com/

In one of our specific clusters, we needed to send BGP traffic out
through specific NICs based on the destination IP. To achieve this
without interrupting service, we live-patched
bond_xmit_3ad_xor_slave_get(), added a new hook called
bond_get_slave_hook(), and then ran a BPF program attached to that
hook to select the outgoing NIC from the SKB. This allowed us to
rapidly deploy the feature with zero downtime.

--=20
Regards
Yafang
