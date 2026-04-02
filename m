Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164C280318
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138617; cv=pass; b=uVCnVmyKEtnaqUi3ESfEhQ0bEt+Vvq1XcmwvB7+F6oBfuR6KgM5YKqoU+XwRX1ne1/hH9+hCyZf/OFUrBfoIAvpcf7VyH88NmMdlLGbbA+9R8z+H5rUea2dlRaPCCKIzarzY5wHRhXVcIWmiCDrSl7nsODl2mI5nA+VhcBSYe/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138617; c=relaxed/simple;
	bh=ZyBDNZT3tKZUZ7qDcwZh0zaNOQse6P3km81WUeBgAxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH9I8Y0eMxNbKOP5rTbJ/RUMSo3ELF1NNSYYv1wctUYobGG7yg9n5e54hHV0EO7OTdPCuPCZeXvH9KnKv4vzvf8Q6UYKghBGVd5dFTzjBWlJLwiXoOQmPg3l3wU6OS/unUWL/+EqzoQh/tuHClQlI75HtV+l5kXOg9h/Gj0Hw0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGl5chNo; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGl5chNo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b87970468so792556f8f.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 07:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775138614; cv=none;
        d=google.com; s=arc-20240605;
        b=aXxbDJ5/BdCLA06ns1WC8mt9oG/w8PA77QATY4swjhNXAdPs9A4lJUX8FejT52grmC
         d4tLnaaCPa4jcQIr2a7fibLJw4vU+GdH1Ez6AV/yvHSscGxGI+B+oSDjkfLdEJFg+HCZ
         q/sabz59YNIkFFgq7Kmo7kQFkKKYDga/krMexcFFXXkfil9kE54zb3EoGkDQonHRJMAl
         FNLfrPDo9ODteALDWNnZFyGw7I/wMuFqGbdm3pzKUUpa4OlAlFAGZ4DBhRqu7UQdYv5r
         0KF4Aa0YamxgSZr+H5nc3XXiz4EL0CNNQgWJ4d109BOvNQrF+pe+oU2QmZO7PKZzE0O3
         wjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H2Q1xAI7WKIB5uC/FrFV4Uhab7Dfj4POcaruiaTCtVI=;
        fh=ANO5kx+OVpnM8wz/qPSMzLOxObf0ciI0U9bTzqPsl3Y=;
        b=Bn3ZYtyH/10qugjCq+Vg/MgIfb8g8HpvtwkAP2mI2lrIATbf7tCuFVbdqOOf71HrN3
         HgowL9wfugL1cvi4cS74AnqwPiolTiSbs+kxta1DKi04mdq8L12BGL2gtQt2m9ukccPD
         B9p5TAR0meFsQITaxJCdue34i/PfkTl+WoX3CmWcio82dAUP31tERi/OvZfKOYTZHbFR
         LPqoJrY6JXw29rEAoPKTGa3sSkEdS6oT4DBCkhVxl8xiscO77Eo4SlHPW/JH5Q8WoOzQ
         /egMumAyLjiWZTbWHRGKAoEZNg11ymZ+b8csMzsdxQC8Nf/YyMm0iYrN/8fpuJy/45VM
         S4ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775138614; x=1775743414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2Q1xAI7WKIB5uC/FrFV4Uhab7Dfj4POcaruiaTCtVI=;
        b=hGl5chNoqz3PsH30zOjS/V307lHsahG1n+DiONTGTfKLxImmaKSp9Cm53M2hKKPdMS
         yMuK09lY94MMpgrUAorwhInvStLF+M669P7jm5kECl8yvOhGqKjeHEQUre4Md32wI9B6
         BVT7P2v0XOC1az529bxAmOF2cJX1ThMrGdTA6ScJ4YzEmwiNm0yQ9V1Y9ieFnUfJN+VC
         Q8ChTV4dOXXNnrnLghVKd+Le3kXEw2vIs4fCr6n1Kzv/DccP44SQC3fp0e5+rA3PcrqM
         OOSQi+fy3cUBH4ahQ0svZ7ibTaxblSUa7I1axPbQ+eplzLsQ8jEpGqVbRMKK8Gmfs4de
         scUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775138614; x=1775743414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2Q1xAI7WKIB5uC/FrFV4Uhab7Dfj4POcaruiaTCtVI=;
        b=lR8OcnGw6rGAcOdVN1z96BpOE/+aag1afA+yMqjvqfhYOWOqFTl5s4lVyfjVyuV40S
         Ms40BqrdrFqVbv50NmbJEeBi3LYUiIkBk8866Aj0xP/YYqL/3QFOYzgrf0ofgonUOXCF
         m3jEUdjc6B0mN4TnjNjyhOTponzixd1OBJBwhOpG5MSAE/zd0LpdxSgPDYz32Y9FQvTj
         EJlcuOuSjcqMVB/BPiPliX6DMg15rxTcCWhSFJYLu2mbtRSv7SwPiwCk+S7xKAcDJRfV
         dCph0H35nvNrn/VvCmR1zY3n0Iu86t22w/8Ef3b+ysu3I36VjoHON7u0589c7vu/K4k6
         335A==
X-Forwarded-Encrypted: i=1; AJvYcCU7YAZ/1RQGMM/YC5NSlnnWZoM5E6ePKhx/eBiCFLwYWMJ0NN+XXDDq0kZwApPpYNA8bgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANKnag5K8D5gNtiLkUweZajanDQULXt0s4QpztQ6R+ruqe1q1
	6l6fNOVLVfk7IkD1QEWaPGVRCJQdYpxhSKgUV4Jayg+PF26M+81vzdMyHAUD8jVmVXCNPWf+L1C
	JSZmD8IgH4WufBbrGMsJucyCxogidk1k=
X-Gm-Gg: AeBDieu70ZO2I3bD3aF5gtPJLRoVCSLRD49j+wLJpsbM1WnAlaEygX0ovh9UROdfC/J
	WBFmIhmKmW9MFyguGd9MqsGV7dvDvUL63fr7SaBlP7B3GNtcXf8TF/7lR8goxq0uI4gHIQ0C6Vy
	g96EBk0x9sP98jBXu1LzIjs1jWoSX2/qdX06YZt25TMS6T4PZZTYFm1eQKyo6YofCZBmX6KCTix
	0cJE0zbZ7p/e+2lk95Kznc7UclRmD1dvXFiOWKNIkmusOD3K+tCg1cN7Jgq2Cl+NnsUuMMgofA8
	0mxt5HnP47KGkJFasRCg/hZqSnV9A/eYGALra7Bv9xVM63T876iwF8jLg40ghJsMYOJFZ1lntr3
	+Qy+yIsfuoyh7KDeU9qCkvoOQ3w==
X-Received: by 2002:a05:6000:2586:b0:43c:f257:c6fc with SMTP id
 ffacd0b85a97d-43d15049fd3mr14986480f8f.10.1775138613931; Thu, 02 Apr 2026
 07:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226085240.1908874-1-alan.maguire@oracle.com> <3da0919f-f8fd-4cc4-8e86-aa55604e923c@oracle.com>
In-Reply-To: <3da0919f-f8fd-4cc4-8e86-aa55604e923c@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 07:03:22 -0700
X-Gm-Features: AQROBzBasgf2AsC8zBYeCQj-zVL3P3HcSzo4m83GUp8nUho0cf5OPOiV1zncz7s
Message-ID: <CAADnVQ+C=XBhXasNNrwrq7Y9=p0RyoQ882h9+k+LkOB8BtRNMA@mail.gmail.com>
Subject: Re: [PATCH v3 dwarves 0/2] pahole: add BTF layout encoding feature
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:01=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 26/02/2026 08:52, Alan Maguire wrote:
> > A soon-to-arrive v9 series will add support to add BTF layout
> > information to BTF; this describes the BTF kinds known about at
> > time of encoding in order to support parsing even in cases where
> > the kinds are not known to the parser; the layout relates a
> > BTF kind to the amount of space it consumes via an optional single
> > element following the BTF type or a set of vlen-specified objects.
> >
> > This series implements the support for the BTF "layout" feature
> > but does not require the libbpf changes to support it; the feature
> > test uses a weak declaration of btf__new_empty_opts() to handle the
> > unsupported case.
> >
> > To test pahole with this feature, the following approach can be used;
> >
> > 1. Specify -DLIBBPF_EMBEDDED=3DOFF option to cmake
> > 2. Install latest libbpf with associated patch series with layout suppo=
rt
> >
> > Alternatively with embedded libbpf the changes can be applied to
> > the embedded libbpf in lib/bpf/src.
> >
> > Changes since v2 [1]:
> >
> > - Resynced, renamed kind_layout -> layout
> > - Avoid encoding layout info in split BTF since it is a waste of space
> >
> > Changes since v1 [2]:
> >
> >  - Resynced with latest pahole
> >
> > [1] https://lore.kernel.org/dwarves/20251210202752.813919-1-alan.maguir=
e@oracle.com/
> > [2] https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguir=
e@oracle.com/
> >
>
> Now that the kernel/libbpf side has landed, I'm aiming to land the pahole=
 side shortly.
> We'll need to resync with libbpf when it is synced on github too, but for=
 now it would
> be good to get these patches in; unless anyone objects I'll do this today=
. Thanks!

Ship it. You could have landed it the same day kernel patches landed.
There was no need for delay.
