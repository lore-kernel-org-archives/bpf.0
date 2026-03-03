Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48136C9F8
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548724; cv=pass; b=WmbaRt4uUBdNcj9GKUSfXMD/NY8hoCY0DHI368hnuxDy0SfHsD6Ogv5H35ZplNFuWKLDyqaUwW5bhCYKxK52gFzBiudWPb6cIIXHIbMMEOSIfUP/wwK1LBMl1/5ZkkRpNEozNA96SgsWi3xEgP8iFAJpJ9xL4NStjXVrSk1QJ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548724; c=relaxed/simple;
	bh=eePFz1p6AQfK52Dfp6nhDG5PiFLOvEXjAnIw4amVPCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFRRjucT/p4GC2bVx0JUe3u/UIaY8dTvqrDYDMyi5D2rrQtLhAe6y5GR1mzvwiE2We8D8Mk9y9KN0G5jhJ0zEmTWYeiSDBPKl+S9RR+/pkAlorQZalYawRE/41RPwZ3RNc3oSXWUBBdrVZR68LheKv1L3NDMIMEYOci2wcCswkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSXza9Tk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6OVq1A5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSXza9Tk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6OVq1A5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772548718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uByqIUprBRkKO950etTatx08ahw/9qF0/t4J/O2bhx0=;
	b=BSXza9Tkf4npMAacUmJDCH4O/hXgjwDTwbOWW8io7BVKshm9gEAXOq89F14TAYu+4YIPrn
	VMnNiOUW75qljCriuTGkUfzWgFwj+sw2Wyr9KQIZK7zAFBNpZC5/wYwHALmBdrb/pr8Cpf
	7ueaEQIxRnOdC73+49yl3v8vJUbQbAg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-DxVMlG0bNFSRtUPFqPHw9g-1; Tue, 03 Mar 2026 09:38:35 -0500
X-MC-Unique: DxVMlG0bNFSRtUPFqPHw9g-1
X-Mimecast-MFC-AGG-ID: DxVMlG0bNFSRtUPFqPHw9g_1772548714
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-65fa61297e4so4518466a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 06:38:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772548714; cv=none;
        d=google.com; s=arc-20240605;
        b=IIe3XTxuOo/gxXm9AWd+bam6djj6J43OAH5/Uuv8npmq+g/XPyr2IAK9rv7OhZWvVv
         B1ZYsbRdijKMBXrV+uvYq1wBcwYPwpkfl0M2U6gLe/sCQD+hNmMcSAer2e9IL/o8TVA3
         KJJLYMs2A0ENwTtXjhjnftOg4AKlVjtqeQe5KfUkrN2BnvdpRy0Wniiwi6BHmFLeuDmJ
         yWbSallUWOEnYF9rIeqp1q/uusHWs/KaTCELZvsWWyjcA+YQW2FUTA19xmCxBlhCvk51
         mxXhhTF3LSslDY/m5/YHQNUU3IT+STjGxZhqNOkdIVRhvVoUKT9RQjkHWovB/T2wehMd
         KLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uByqIUprBRkKO950etTatx08ahw/9qF0/t4J/O2bhx0=;
        fh=9/vsqYlXOs53vsyz3Up7uxItIWMOOE4R3uIfQKG6CmY=;
        b=YnyOe2hC8ATaMlJcv5zCZnW/kNcV0lZhPFAPuRKhsivVfn2szmsAUXsPxYue7UmO65
         kMeWX+dl7KNIbU/OxWqNG8bghh8R5r63VatiUUEEXmEGls+mQj+Bubi1sfs3vLo2i60d
         IoyQ/SkPbuX9IbaVOKSPzf93jsHHNeq5F4uLRLdYbiwqEggdl8CjDfHNH0zxz4w0Zphf
         bHvG3Gut1HEp+YYrfd0VOZvTXRHtBCPK7K2DcB3cD6vrSPTUGx17/ShGZlR1AcQl979i
         aDDUVbbmwxAkYP8aFf/sRzejD5Z66TiMHRhBA08fv3ZDGVtQsBTOaAqnaKlIFNg2bPVB
         tx4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772548714; x=1773153514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uByqIUprBRkKO950etTatx08ahw/9qF0/t4J/O2bhx0=;
        b=e6OVq1A56199PYjUG1ls7O5RgFLmMn6uQWjJgcu98vI7annvzU/USwrscBiQFBLqET
         tJyXcCEy54UofYneO329NSsdNIgGxYHH1ZyzQdy5m5n9gQP6347MBwqczUGv78FIvp6Z
         MVjx9+A/sSEeLCcriRT3d/4nqWNvJP9IX+0tDQQ7k1yBHfFcvq8CtTYoLjHLOg+3nypO
         VabsuOoYyZpw0dC/2GV8yhqiovCiLmYUKVjphAY856INHAgpSw2YHr3IzedmldIxt++j
         Vgw7h6zyYQ9kQd0mHlC16ZWy6O0C4hyiveq7x5//AsSJQG0c/y0pIStMfBIwkzGASPlr
         5zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772548714; x=1773153514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uByqIUprBRkKO950etTatx08ahw/9qF0/t4J/O2bhx0=;
        b=JIYt9qAMhNV81NHdYTWrlD/XaIPS/kuZUjLeShPiS/pxYm8cncy4SFUNpEgRjD1otb
         CsziCL20wlHTcKtI8a3LNDNId2bS6IA7JJ0joXynlRx88Ox1DtSGSmMq5Wl1dmN8HgWp
         WIgfe6uKrWb6O6wscHqookVTGQzbgwOmZFrb8cCErweZBsp8hYI7VdLLk0qEWvaQpLEy
         2gHkGiwrbF74H4csip5Qid/VR2veHnbPrXqJrdQoncz1NgS2hsa6lQ4yFAqkcGajEK/8
         xtfqbCNXbUSkUlV6snRDvLLQL89uVKNG8MD1iS9GRGrk7yb4gfPNbPH8HeLpUi4ckvLw
         FMvA==
X-Forwarded-Encrypted: i=1; AJvYcCXBuDfK3cag8zWJZzh004Zu+N7t3N49rlYlOcIUDBQwEk08mGSoFw1Cn+hLu/8Q5B8bBs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0EjXJKvjZNWDnsKZvEm9u27LRd9GCp6mPI0QV0pmd2+miEWV
	hDRPOJlSEtcQhWCAK951rHJSIqJZL1a+DzMqAbvzjMbG3do53ZKqRFbRLhRpptDemrLS5w5rFr1
	soa7hn9io9kf0aEWuSOSWvIsvXRC/lwr9gt9VECuPQTAutQU9PBY3m2VZdJk0Gs6X0qdeGHzWp1
	DUJ8wOTP5LhWmOsvNfLCah6Fwxv4tn
X-Gm-Gg: ATEYQzy1kaFbaKDFN5W8WawNI6XWLmxtnE/mC9FTqopLS33Kn+EbwwBpHFBbhjnR219
	9GsXgaMh2S+EB+HD59FezA4461UwKkELbzU/7HkXG3HLOhSFtD5NDqtS27KF8PRgLOyN5r9rHOJ
	fLszd3MR7VSUxnotWdLfT0GI2QMQOu7Y21fAOlqGtlSeZFi9xH3vxNM36a9liPk4FpHPOtgdiFL
	tK/tA==
X-Received: by 2002:a17:907:a49:b0:b87:2780:1b29 with SMTP id a640c23a62f3a-b93764c7e7emr902975766b.37.1772548714036;
        Tue, 03 Mar 2026 06:38:34 -0800 (PST)
X-Received: by 2002:a17:907:a49:b0:b87:2780:1b29 with SMTP id
 a640c23a62f3a-b93764c7e7emr902974266b.37.1772548713579; Tue, 03 Mar 2026
 06:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-15-wander@redhat.com>
In-Reply-To: <20260115163650.118910-15-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 15:38:21 +0100
X-Gm-Features: AaiRm53Eu2RQAmILp0LANpphIwNNYI7ejb-zkRgheOkvXJcE58fh1F24u7Tb4FM
Message-ID: <CAP4=nvSyD+hYdPkXQ9P0KPLw0rESh3A9Nr0su1fvkTAJfAOxzw@mail.gmail.com>
Subject: Re: [PATCH v3 14/18] rtla/timerlat: Simplify RTLA_NO_BPF environment
 variable check
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:29 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> -       if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", =
2) =3D=3D 0) {
> +       if (rtla_no_bpf && strcmp(rtla_no_bpf, "1") =3D=3D 0) {

Another use case for strncmp_static()?

>                 debug_msg("RTLA_NO_BPF set, disabling BPF\n");
>                 params->mode =3D TRACING_MODE_TRACEFS;
>         } else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "t=
imerlat_sample")) {
> --
> 2.52.0
>

Tomas

