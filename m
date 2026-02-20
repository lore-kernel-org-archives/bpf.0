Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D41B652
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771546144; cv=none; b=XOuZASD2o7WFMkyzBFo1DuRO24Kh65UthHcTSOKJFjTGXjM1KKJqmEkdqRisSj8GEOx3hvExNLH5cY4S1MJO/7m9m1Yblq0SNQ7B325iUFKHaRp97WaOwUlh76z44rfy5vdyTw3UowOBK7nucak6zsSNDbet1H9VvtOFoX//DJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771546144; c=relaxed/simple;
	bh=66ZQe69rYy/wMmdohuUcy+qkiZ5/gWAtVFp7B4SGx+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KcJ2WW22exYhnnJsLJS4Qe1bcBZta6uxe1nehc1ont3CKp+/icRySd4bQXPu7ihmOWeYo8IwHXk06gs3Y1J8EUa6RpvwKQ2eu/FlBbUlFUXPcwxi2qiC3BIPW+vsKf23hvvseU1aM+rFv/MIXAFvPB54AUttzqRpEzVblkVpZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRNsTq7g; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRNsTq7g"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a871daa98fso9668175ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 16:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771546142; x=1772150942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BdyC/D8vx6/e5N53LQNiXx5/xtz1jQw9tXYkyKMUPU0=;
        b=lRNsTq7gSlMwmY00yiSZw80qEdi6KFtGYD3l7Wi23AmR009yopegXcEDxisFyHqPA1
         HgwGTW+LhER1p3Ms2f9wvfqeo5C41r8JEA04XksY2u/5iKszDFocCPXuOt66mOs4uAjQ
         zLZxpbbsR9W3qW1OGH2vUraHVLqGa0zGKnYHduwdRmY7jU/6f62ldlNCHoJcdgsqib9m
         ZURHvp8VtSRnr7glaHF19eeV3fanzGNlxHOyniQcczPhbs42HmXufMLeAAx6LSQkLg7m
         KffJTEWFy3P9DO7pMupJprZxgr3MYwhp1K4k3RuIstKGOCsn1gYTBori+sOA5wIfpFUe
         2x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771546142; x=1772150942;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdyC/D8vx6/e5N53LQNiXx5/xtz1jQw9tXYkyKMUPU0=;
        b=SeDQuCTMNcghUsZPsjUAqCNCJyEMp46CviFRQN3CJi/IcclnThVVA0asBRC1i9S6x+
         x6u2eG0+7Ay4Sb6TsMWlwYtopmforD6hT8VNcISqmfzZqI+xmpkfLrUmNKfcEaaH4Gfh
         SzlBORG62sbO/qAKlD5SXaJjpxeaHwDfB9wWK8v+Wasj3zaW8yeJpG9iISIHqq5+a5iW
         c9O/lBecPrekkRcDmKP2hgRzF7kQkKiCVFhoiBkZJylqpskjarFqop4S4rgbC2n+VRw5
         mmkXJCOvBQCfrZaSsCyZi+jnaxtLOrsb1C9WtzsQObysNB9kRp6eOZRVyfzMua9nXjBY
         C0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWJkg6xouEWSZbqTYGX8+u06a9RI3VgAiYIHwat8LyFsLhV6AGkreDcW1QBtHUgQ7wpb4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzax2Vm4wVM+QhKSMRH/inQMtJiaAWuPe/TfMIjxYDntTa6DWfY
	VZSadnxlHX4qUJEZTCufC4SoTAD31VXZUof8DX3M4Y5IvYF3HXzD5I3X
X-Gm-Gg: AZuq6aJ9RecAXGCCBXo++7W0CI0XQgZ0YHZH/CswMN4D6883tcmP0JnQ4yr0X7If3TN
	2Wj9FurfoH9pn7CdmU46uwgvmJBstnN6IuAj7PUDXQIXDtieagepbSgJ/b8pDQr6tRs1aX51RY2
	P7Q/pvcMEqO9yXiSlud+EG/PCP5pSBy2Ol5GmfCuvQ5x7mOis38BNxHKkPKIl5Kp6Kq56ag5O/X
	/62uJHxD5qqy7Sem9dhd6RbPhCqPG5W7BrIKzkGE0BpAEJ4EbH6Yf18r8xUKB+snEu7EQuYyHQ0
	5Ka3xBWM7NcgwEBSM2uz1DCu7Ul7sGrhlXXJZKh95s7jbmm3x4ffmETT6XNIkN03f6BzhNxWtBz
	31c15JsTz1ozmwG+2vF1gLvLLDpnt+nqgJcr6zJ69+Pv1Vl3JFgfr0QuD5ogxDH3LNKBRwDJS6l
	BCumD+rhDANf8Hq1MZ3Y3Agaiq8sZTfP+09YhcRofXKTbbrMnYsxEKctFUXckSBQ==
X-Received: by 2002:a17:903:1248:b0:2aa:dee9:1ad3 with SMTP id d9443c01a7336-2ad174337aemr216680475ad.11.1771546142314;
        Thu, 19 Feb 2026 16:09:02 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c58sm188709085ad.59.2026.02.19.16.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 16:09:01 -0800 (PST)
Message-ID: <4a1a2e532459e8636c3f7ecfd4e46ff13042b1b9.camel@gmail.com>
Subject: Re: [PATCH bpf v2 11/15] selftests/bpf: Free bpf_object in
 test_sysctl
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,  Mykyta Yatsenko
 <yatsenko@meta.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
 <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Thu, 19 Feb 2026 16:08:59 -0800
In-Reply-To: <20260218003041.1156774-12-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
	 <20260218003041.1156774-12-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 16:30 -0800, Ihor Solodrai wrote:
> ASAN reported a resource leak due to the bpf_object not being tracked
> in test_sysctl. Add obj field to struct sysctl_test to properly clean
> up bpf_object if a program was loaded from a file.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -1471,14 +1472,16 @@ static int load_sysctl_prog_file(struct sysctl_te=
st *test)
> =C2=A0		return -1;
> =C2=A0	}
> =C2=A0
> +	test->obj =3D obj;
> =C2=A0	return prog_fd;
> =C2=A0}
> =C2=A0
> =C2=A0static int load_sysctl_prog(struct sysctl_test *test, const char *s=
ysctl_path)
> =C2=A0{
> -		return test->prog_file
> -			? load_sysctl_prog_file(test)
> -			: load_sysctl_prog_insns(test, sysctl_path);
> +	if (test->prog_file)
> +		return load_sysctl_prog_file(test);
> +	test->obj =3D NULL;

Nit: is this necessary? The way `tests` is defined ->obj will be NULL anywa=
y.
     Looks a bit asymmetrical.

> +	return load_sysctl_prog_insns(test, sysctl_path);
> =C2=A0}
> =C2=A0
> =C2=A0static int access_sysctl(const char *sysctl_path,
> @@ -1573,7 +1576,10 @@ static int run_test_case(int cgfd, struct sysctl_t=
est *test)
> =C2=A0	/* Detaching w/o checking return code: best effort attempt. */
> =C2=A0	if (progfd !=3D -1)
> =C2=A0		bpf_prog_detach(cgfd, atype);
> -	close(progfd);
> +	if (test->obj)
> +		bpf_object__close(test->obj);
> +	else if (progfd !=3D -1)
> +		close(progfd);

Nit: close(-1) works fine, as well as bpf_object__close(NULL),
     so there is no need for 'if' statements here.

> =C2=A0	printf("[%s]\n", err ? "FAIL" : "PASS");
> =C2=A0	return err;
> =C2=A0}
