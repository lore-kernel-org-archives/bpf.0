Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36B2DC328
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431402; cv=pass; b=ZtfWNr//GxrYrrJ1/tTqyT0GlIiyImwzOGS6J6lQxsEpTy3EuLI33KnsipSkorhnx90TM6VXBZeRJ80jh7MIeazB4JYJVnc5b2PWFlGNSyq9Erm6xJQ3QLxku+mtHzJWkytWrtFThcHJZn9kENI8kIRJOMtB0x/dDEf9FW4ioCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431402; c=relaxed/simple;
	bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4J1unrP1TqL8csDz4N7TU9MBGuD4OLpGZxzAku0OWWL2eQF0HGiGCN3x4FDRhcmTsa+6x51yaKRYrIc7ev1jhCGlbvEQ+FW/BsXcTvC4EzEQhq6suZ9CVv+wPoYLFxRzgbJb+BI277eSyrcIlKMT2PPcAY65d9dK/4A4SpLfqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGQ59qt3; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGQ59qt3"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-948bf40406bso2560241.1
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771431400; cv=none;
        d=google.com; s=arc-20240605;
        b=Se/Ec5RXHZoN5mrWQh502oU2eeJxgIj1+XjeZET1NTR9J6aDUb0V06nh2sRp1BYVaq
         4LMOHmJFymP6D4s2jcmmyxL1RnDjmKangkI5qZhqePgFG6XN9jHZd4fn5yxxFMQ6bILx
         m1pj2JbnO8ri13SZBrvGmeVySsMM6cTHlxXlSymTiuCod8hS8uakMACAuuJ08pFbGFij
         v9mW6rwelR7FQd+WfrigN7IFNmNPaSwSH6pHqFJZzKga1fmR+TX8mctdqFpyXgnV+u88
         MWnH38xln/n/xepd5C2PwWdj6cmNi2okwn4SGxybNwhcfT8ctc6ONg3GQFfvKoqJ8UL2
         fSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
        fh=8iu246gCnQO4Fj262HaFknkvF5Enmv98LMB9UW3y69U=;
        b=OAtxlQC8I+KGWC7SwDn3vOaEjW3abvQCBAXN46QHQiRjS1hhzZRQxNMym4/aN/gXoz
         uS9+Zfg5MhlnSgS2egUnREQJhGLrAno44xk6Ifzsn7rXxYpjfYXBcvzN2ruRVxzrUDWc
         LT0C2AzG94qqOLkjUq2s89zgvitsO2ufp2VHBQftrT+xOXIusQd5B2D3RIl61Y3FjEGk
         xylBePh1DV/EyxKqMkAimA5EL/99gwKQf5yu8AdUIVCQc/nEHv0o4c7ZfUUr6+r2/klv
         KDOvtn+kIZ76Wwxu9TbARcmSTkp9P6e1d3hZWIO6uwXQ+bVznwjq0T1zbR57Ul7O3b+E
         jTYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771431400; x=1772036200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
        b=aGQ59qt3lxjvyW5qgAPBjzAhFrLxnsK0pjtDclfrXOH5rLnETDgSltMwNrRzoFYQw4
         girL7QFOhKBoZpA8/wy0GRDYU1vPshk1rxANkb/5d6oRe0q6oWJLxK1aoqQN7MEiduDg
         ke+DtyFHtOD7BUyVaa6aXnteqCuAWZsgADWjyW4hXJv2dTQ+NAD12SEM9rlZCWpPGOkZ
         0CjrRqKKbYt9OsfzjfQPBl7u778hsRx1+frTDWI8lDOBnr7kZx7TvDGBSJo8gp9FN3Q0
         y5EsaTzap7fLkyiW4PQWtZnTr/gjs5B1r/6U9aGwNR1MTSiUxVZ2KXeVzQpRSnAoy61w
         jEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771431400; x=1772036200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
        b=UZ6pqfyQNaRTazAp/1SQflzcfUvkg3utDxetCsuTqTtyKNopfVwIHTAHwrwlaosNbX
         z4kUT0QCPaUbYPMdH4Y4i/iw4o30YfbXfEHhIHa5IDfZ32xCTtTwRtFcRLuPqB82YOJ/
         wIqyo96bYvSWnl883rNG7cNmYVWK4O1rpYYcT62QxON/kC2Mgfb2fqk500q4JAvzNfz/
         3HMrwsKmsxzw7E1+Fg0G++C16ne57r+z9BqpWfk9Fr56sIbCP8BRIrtVrjubNXhdvSH+
         nSpD/+T1JR4mB+t5ZL2Zj4U9ks/rKyNAWvYrLhMJSHntGQitxLbOaGIQrkDaaqNb9ZFY
         b/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXm+thFL6u/ZoH5Sh/VaskzhMMgLqqZ8fHIhp3+zvPPdQ6S2L61QPCHepSCatyeK8T1hQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJeGyuXy/qelmK92WzoAjI+mpfTy+Le/Zb13CLL43PgwFm/N6
	oOcn07qU6ayQOGTswjJ5hPyPcSz0v7vZxv+vCh9C2IOEozYK9/z5Xi7Yj46M12VytsWwVOaCiSt
	beiU96Cu+gdr+3D/99+pv12j+ae2WwU0=
X-Gm-Gg: AZuq6aJhHuw0W9p7xymgI7knIbya+p0GGRPnnEDxsZ1Rm+SR2jI0tBQD8WEYSEeWHYQ
	Nsj9a4gnPGeQUtXdiuTxg7KiB0xKOXbhYtDCFtZbmzSBoN1LFW2ElLpkzc7NBffrw0u+G6U3O29
	rF/5580/bzBojREK+RZD4HSNwPWWFZfI61/KZOLG0JFDBGJs2bqFsXTkqCu/Elcqrv/7Eoex7R6
	trTuZQgsLIB95i/CUXQrOHhBIOyKXro3pgc9eBW2SnkRI/nR9p9Yqf573OJqXaJaEA3VrXYrkAf
	RHaXqcIa33yhJCj45nXNjs8mZ/kurtBBW9gtePKEOhH+LD9c5/W4xIVpikaExg==
X-Received: by 2002:a05:6102:942:b0:5f9:362a:8e61 with SMTP id
 ada2fe7eead31-5fe2b003fe5mr4897521137.39.1771431399417; Wed, 18 Feb 2026
 08:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com> <20260218104328.14341-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260218104328.14341-1-slava.imameev@crowdstrike.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 18 Feb 2026 11:16:27 -0500
X-Gm-Features: AaiRm53xQrJ6ikwNR6kkTu1MPp0M2xsnhx4ti2O0jpdoLOolu_Zzsh4x6LDX49E
Message-ID: <CAEXv5_jU_OvD8abO6YC-sCfcRpTt0xNAyb0zUy9Km-U8TTDdQg@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	haoluo@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

> I decided to address only multilevel pointers as this is what we
encountered in practice and have to use BPF helper workarounds.
I think there are no technical restrictions for treating single
level pointers as PTR_TO_MEM.

Hi Slava and Eduard,

If we add support for writable single-level int pointers, we could
trivially implement bpf_inode_set_xattr in the way that Alexei
originally suggested[1] when it was first attempted to be added.

One note, for this particular case, the kfunc would need to be able to
write to the xattr int* param, as lsm_get_xattr_slot[2] increments the
LSM-internal xattr_count. Others would be possible as well
(cred_getsecid).

[1] https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html
[2] https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/lsm_hooks.h#L215
