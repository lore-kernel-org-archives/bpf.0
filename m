Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBB3A2576
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620231; cv=pass; b=YwWYeZsF1Mu6fo8rCD5tw64xUbnWwZd1oqZv/YnEDAXJP637ap7GtGGagntPZOsrlUXVK6rFD/JLqcI273NzCNdrm/AldkypvU7A3idEw4A89UhIQfBYow5/evQ+dBXx8A6XM+H4Eqyz9rQHEkIYsSQr+30R6Ky+QCK8dGxXPIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620231; c=relaxed/simple;
	bh=uLpdqpGN99/E//Avoz4o9MseQ49WViflUkqW9bUCsnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPvO6xOdasth9soDZ9xA9/TSoiAbEoN+pCUq+1K/if8COs/f1tuOvmSkjSb4TQJjWlMPE9d3Gp++3IknaDTzoAhcgYUQS9e+DIAV+lYDjBPDTFuZB+LKy+/ebOpNjRCUKImwNZjS11vFkmp/WnVlsp7qWAidwvwYfLvV4yEMyeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXTHY2fZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jsfL03Wz; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXTHY2fZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jsfL03Wz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772620229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StCiTICbmC1xh/aY+h5apEqtcUPRVdpBQ7SveVbW1g4=;
	b=WXTHY2fZwXFsTZH3zf3Aud+bMSvY675bwuKcovS04dUn+slgrEPNo5Gyxfpy3syjSj5g6C
	Hv1UjPAVzywirC07wGinPs09aqTw1kb0I2SoQQuTF5MmdTznBEeaMaPJVOAZ7D6ITNsbwn
	PjI8mm96coS7d1Q0blHjs402TPXWEVs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Wd_WDJRnMDugiNg9WzBU-g-1; Wed, 04 Mar 2026 05:30:26 -0500
X-MC-Unique: Wd_WDJRnMDugiNg9WzBU-g-1
X-Mimecast-MFC-AGG-ID: Wd_WDJRnMDugiNg9WzBU-g_1772620225
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b933c3a6c64so621335466b.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 02:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772620225; cv=none;
        d=google.com; s=arc-20240605;
        b=MkvPGUJYSIO0J9JyELhGC0liJK3I2oqCMlLca+SoIRFK1HQsXZQ2/azS9L32lgtd2v
         I1Cl3a2KElzyTq/eLujHp6QKE/PS3W7Zf9fxUiobDl/jpqZGZBlotYXTODAG5xGHnGCf
         kDYIxmjotP2mZHZAY/vNQX7Rgp16ViUy3dARb+DBq+eIDcWTz2P0G5ZIoE1Y4ihajgj0
         gO1Hvvz9gsVU2FmBgrp59mEVQICpXaxolF/iHZtf81ndT/YqjZ3doVLZoftldBnkEeMH
         SPhFPpYQLcRM4r1zBuN8GKN+aY2wwuD2LrVY3hqhRc0uU7n9c9EATzhev7WIVFtxZlmQ
         Bl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=StCiTICbmC1xh/aY+h5apEqtcUPRVdpBQ7SveVbW1g4=;
        fh=tJvbDlwIm6KwbQFZz4di5kDbGs3daGI4N9RUK6N0a/o=;
        b=QK1fNtOxxQ4e4z5FQ9Btj5z2j7asLt+JU5usaHJwrI0kx4rGbMIjwTMTo/jKzgcjOc
         Wfq3DPliDzMYl41UwxLB07a7F5T2471HtmOKhfLPxvUi6t59QNA5AlsqfX1WjgpP2wSk
         on+p5DITXNgsN0HaIWyNaoFHiITAnuYkXrbfmGL+FiRZ5O+o40jfH+KNwrMky4nu/GfS
         bwt3UCAQBSbNJr1KvroMsMgPuGBRoqnbiuryHYVIhEUtQOqDv1Xbc5jF48DfPZuehfk8
         uSI4vm06ZBgSJn8Solak5u8ggNYFysWeGQC7xcwTPJE8Z8R3GqNFq+kY5+8paLHQ0MIV
         qSGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772620225; x=1773225025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StCiTICbmC1xh/aY+h5apEqtcUPRVdpBQ7SveVbW1g4=;
        b=jsfL03WzJRWgXd+U5b1dqVGlqHgISQ55P1n6C9Uujel77bub78q2c/GKwXcirkaEz7
         xiL62m72XpyWeFnfaWUPFXmj258Mdr0xTyypkjOp5NT9j3WaPo7rH2tuFj7lzSJ/eqLi
         gpb4UAlZ07a22e8j1ny9X77ncPEPGF9HB62zl6tekHKcaR1se1AW1jl/3qEAyRejMWCI
         y1t4kdrIRBZBMFgFBJOXThQ1qQ0yv3d7TpD727KB/26PeAPR5RZzM1zZmpJbGQkcV7cv
         TSQfXxnURP5N3oW1Kk7GWd1wIo82slpDy5Bj7nZda10k7CjT/eVT2Q8TUxz/YuxiI2Bx
         plwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772620225; x=1773225025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StCiTICbmC1xh/aY+h5apEqtcUPRVdpBQ7SveVbW1g4=;
        b=ZvB/y/E0Yjf7wQy70YZ8+muoxRYLaoDVGtABIvN6/N7bJvMeQAuDcpBpb0amx9BaRU
         ZO4tsNE93Dhc4X1Y0hDGG2Os2WJcFfiRLgQQSzWHkmsP2Xiq7loz/29RdpNb7L8e0Eqv
         8AvgV/e8I3sBOxvs4BJfwSVKSwie2OItAlQinldKM8hSXDb/ezjFqxWlERIPxsvBXSZI
         rBrijuuirIlxBVi8oylTJ3Tmx8SH+6afAWwMC7vShRijau2h7DjHLx4lulYQYoBLnLdo
         p3o6qe2GfLbB7HdLpDZLfBaClzWkbpbd1CvdbqF/igY8z+tArCJGIui6jHde9tKiFUzV
         4sqg==
X-Forwarded-Encrypted: i=1; AJvYcCV8agqDoG9qltSxtf3cLrQvG6fZ7UlQrpefx0xM2pc07mDXGUecYLh7YoTFr1IZkE3Am2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7nsSMYmJw8q2MHOz7fA2MwjHjOy4DGBvvwP6acaaj8UjZOfo
	O4CiyrOYsaLaoij8d7SF5TE9W0f6gcl+9POgEGhZOKqMK8HM9gI385107ZaAcz9eYnTWlZl4evu
	fhVMgbndTIUTYwWZHKbnkOOLQlWZ1IwJWSpNg/PcGmkpsRGqmqL8ygLZgAJvrwgfdkHDmtwtqn4
	1w2unPtj4a8NWi7o55Zr18FJKy4nMH
X-Gm-Gg: ATEYQzzV79eoawG8WdHJOh7N5oUEtZ+GnfTsUNET7CQcVpmk+3QS65CY+4A1XdDbQ+F
	EKStBhO+lDXoAKueDWi2Cdxk9cEL/6GvYXjejomTngu6Bsfmr4VEUP8xMfi5wkAOkNU1ckzvKy/
	TiJPKg2OCCgHE/UcdzebwbznbXQhSNSFiXkUS730jIm7Oeg3lbuC1ORW3jvLkuLemf8Qb1Egwd5
	2KrEQ==
X-Received: by 2002:a17:907:6d15:b0:b8e:d1f3:4744 with SMTP id a640c23a62f3a-b93f1594108mr84213166b.55.1772620224903;
        Wed, 04 Mar 2026 02:30:24 -0800 (PST)
X-Received: by 2002:a17:907:6d15:b0:b8e:d1f3:4744 with SMTP id
 a640c23a62f3a-b93f1594108mr84210866b.55.1772620224457; Wed, 04 Mar 2026
 02:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-17-wander@redhat.com>
In-Reply-To: <20260115163650.118910-17-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 11:30:13 +0100
X-Gm-Features: AaiRm52jWeoiqQEahwH6YFi5tyb0O1VzmWB8Yo5YKKa3V6s8QIEV42RNHDw4RzU
Message-ID: <CAP4=nvSBEgfJg8qFYakiSfhE-Cp3RF9OoT2NR2qO+oRk+1BGEg@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] rtla/trace: Fix I/O handling in save_trace_to_file()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:29 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trac=
e.c
> index fed3362527b08..8e93b48d33ef8 100644
> --- a/tools/tracing/rtla/src/trace.c
> +++ b/tools/tracing/rtla/src/trace.c
> @@ -73,6 +73,7 @@ int save_trace_to_file(struct tracefs_instance *inst, c=
onst char *filename)
>         char buffer[4096];
>         int out_fd, in_fd;
>         int retval =3D -1;
> +       ssize_t n_read;
>
>         if (!inst || !filename)
>                 return 0;
> @@ -90,15 +91,30 @@ int save_trace_to_file(struct tracefs_instance *inst,=
 const char *filename)
>                 goto out_close_in;
>         }
>
> -       do {
> -               retval =3D read(in_fd, buffer, sizeof(buffer));
> -               if (retval <=3D 0)
> +       for (;;) {
> +               n_read =3D read(in_fd, buffer, sizeof(buffer));
> +               if (n_read < 0) {
> +                       if (errno =3D=3D EINTR)
> +                               continue;
> +                       err_msg("Error reading trace file: %s\n", strerro=
r(errno));
>                         goto out_close;
> +               }
> +               if (n_read =3D=3D 0)
> +                       break;
>
> -               retval =3D write(out_fd, buffer, retval);
> -               if (retval < 0)
> -                       goto out_close;
> -       } while (retval > 0);
> +               ssize_t n_written =3D 0;

Why break the style of declaring all variables at the beginning of the
function? n_read, added in the same commit, keeps the style.

This also applies to the previous patch.

Tomas

