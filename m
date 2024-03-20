Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F0125AC
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915581; cv=none; b=M/M+VDJ1Ed5mNq7P5r2WyR1EZVXCTC0btrWYaB8g40vhK1VRqFTgE3bFEjOVRpKWIeLKlsz5lsekfLiiu6twyA1Wx1vAivi5koNd021cKH0Vohv4g6zjl2cwXPBbVdGcKEZqrPc9FmazLj4gDR+iU9n+VQI9pbMq9JT5Q0zmy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915581; c=relaxed/simple;
	bh=BSYolbSW2BEXtLU9ECNOvaHPgRPc12xhx1Pv4vXO8MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKTip0ErE7Hp4WDOd4D2LdLAz4gcgTyawnFEHalL48WVKoaYGktjmHz94uh2xoG8RwIZ/Rq9Hj6HXVKUsX0E249toLpoDFbWd2KB9HYDu3loiZwkncnkPh3UvXQyL4NDTvklreJNiDBfx6bb776mCpOQyTWXg8HaZwLtu2aA/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw/oQMfk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw/oQMfk"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e285a33bdso3260821f8f.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710915578; x=1711520378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSYolbSW2BEXtLU9ECNOvaHPgRPc12xhx1Pv4vXO8MI=;
        b=Fw/oQMfkRzhqGCWEkMzr74+osDju4bokblKgIgpBw7cXtzdTCmOrt+TsHnvnjy/ZLt
         zak65fUoVqyvxwvQJVQjMnqErXtPLU0F8+uZeHz1SFWKLzDLYpjVCXDAj+ebXCv0NWr0
         fhr/+SRlZqcxM9Q/pLjwdz+TbN7gUzcylkul3TkGJm8DVW4gvgj/sEQ/zKGZYQ3S7lVs
         j6g7TUwark3VCo1WBNkaA1ZPK6PijYG7cHW4ePZ83EsOm80aq7OKnu9Qs0Cys2on5AWV
         mxIcpD516KKBWPdWfPX06LAYkfaoaQ0uIqbqD0EQ5waFjt/I7k5rnivhwYsRwiY4M/Q6
         71sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915578; x=1711520378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSYolbSW2BEXtLU9ECNOvaHPgRPc12xhx1Pv4vXO8MI=;
        b=lbyoNEnRrlTSjk7tHcm1Xzm9XfglfyHzFRjiwnci37NxXjF+lDCQamcFMQVc/17JBu
         HbhbKEj0p2V8Y6xALAjJrEv1q8JSffX1ZZaDhMkMgArvP6HJ1KUI7UnDga7735ucLIjd
         JS8gVX5THLQVKQNTe3v2f2nFA+H4zX5bOvY0+/GDo/zJof53Iv1i9wZuILl3HYhnZ0th
         Q5NPHZCbuJ6WediUlquvFyRi8uGbTg5E9NHFiWKJsgNDWGDqi3oPJhn/i4MqnpF01p9g
         wXgoED5XipPLTwhvK/BSkPrX2VzSyLPeL7Sg3vSS/JIrCETOqcNcdUGb6qMF9QN/1Qrs
         t7xg==
X-Forwarded-Encrypted: i=1; AJvYcCWdom8/ePuLj8zznWGFvrGwSAdbD+EL1w7eRKIyIHMojWQrLeNrc+j7BXPA7dF8b0NXbTqDJa3YqHMGbuPA3msy+W/3
X-Gm-Message-State: AOJu0YzjJw+2nHnbkT8yTgvrR+0earvw0mus6Wa8sXEBCJf5X/sz2oU+
	/xDX+4PCH6zg9kqKeiiYqtZRbb1qBjOJLFL7Ux2osNPHrZ2um9wz/vrl/gugKaCVMAPkBIgr626
	K+RGFoJzd7lPp7rVKDcomLz671IY=
X-Google-Smtp-Source: AGHT+IGTGAdqUeKincVI6MRhlU3JBuW4qFrxMksyFi1pOFk8dMhnpgaQM0Y7avwc58kVXbGhe1Dl79ZCvbsmLjhdJPs=
X-Received: by 2002:a5d:6647:0:b0:33e:8771:c58b with SMTP id
 f7-20020a5d6647000000b0033e8771c58bmr10942903wrw.62.1710915577805; Tue, 19
 Mar 2024 23:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320013457.44808-1-qmo@kernel.org>
In-Reply-To: <20240320013457.44808-1-qmo@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Mar 2024 23:19:26 -0700
Message-ID: <CAADnVQ+wa6HbQGvdwTTzs216RjJZgmJLyUmLxOgz9iHyddEwSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Remove unnecessary source files from
 bootstrap version
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:35=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> Commit d510296d331a ("bpftool: Use syscall/loader program in "prog load"
> and "gen skeleton" command.") added new files to the list of objects to
> compile in order to build the bootstrap version of bpftool. As far as I
> can tell, these objects are unnecessary and were added by mistake; maybe
> a draft version intended to add support for loading loader programs from
> the bootstrap version. Anyway, we can remove these object files from the
> list to make the bootstrap bpftool binary a tad smaller and faster to
> build.
>
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" =
and "gen skeleton" command.")

I don't remember why I needed them back then.
Probably to debug lskel.
Applied.
