Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693103A7F50
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950171; cv=pass; b=UGU7AkqXBFmFKoRz+88zOgXlaPpwL4Oj+Jyb5nzqI2YwblSUFeInOteBKyYjSyP43cnhP/5+kRES7z+9MkmchzvAcSUgVnxiEtAvzf5ms92cDGgj6tjhObxMHa2wqKwhiRM5N6wI3kbt7YmjU68bYN5nsCJX3Hhb+IP1DPn51WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950171; c=relaxed/simple;
	bh=zElRkeIVBB4cVrg9UxuI6BIZLT/u0RFeegdXTtGlAq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUuvCi4tmcl5r+WIxUGkZq9WEl01O/QzTrYXSSCeX5Yebob2Hkc2Kjx8M4iHy/TSswlaY9xZun2i0FzPNVGTliHBF0FxljU4iDKpDZdXGFEe3RfgaDXHci+yuoUrunZ6DTgYj8aD6vw60GC66L25KHJ9Cjle6YKrjoJtCcTLYKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv0SnCEv; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv0SnCEv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so49923905e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 08:22:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771950169; cv=none;
        d=google.com; s=arc-20240605;
        b=hWxl7bu2ySTuIENLymkXdVgEeQUUJwC7v0/kHOh4eCt97NCN7AA0BS6wceNKhm3l8a
         kPBNs2zTqunrwQdsF/X73eXPdQR9G0jvxWjnoMsAPsH0kVVmtwR7tTRiblXucC+TFmXI
         PgsWf4+s1iSA8aoFHPbVd82vM7xEmouOLF0g0zlG5uIhGyhc3DDbjx3PxG6O210MWXyI
         pSpngPcjQOkrx0eZCGiQsF9/+mcaQNoYJfOqFT8cxCYeFfJUy9naqpCNWnA1NV3GWnLL
         apjcQuGt0pyXHTLZeZqHqjvoCfx2cVezAuVHBrxeRMEZmWjO9KIvo4iFGEAKpVoB0dlt
         8ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JGercx3vkdEAz0Gc46HRTj3KBzubttjIgevwNppmhDA=;
        fh=yaM70o67/bR8/JZS9PK4WeVYSoAlAqXvDzzwtF1uAp4=;
        b=EQg+OhLQOYgTbqOD9ExIuEUO7nSclr/3+Ga7wHKGbWWE4saH9AUDxDqNCLc5FeSX+O
         0pm3EeGqTTHyzeaNEFzISFx9sf/O/+0pYtCt3zQWau/cBECROXyHZPyXsmuYGUXiS0B+
         +lPycctSALA/m07uYBrenjxU9vruVYShud07GFVdN/5dyapN5p4+NmcWaVBonTn6YBJV
         kxrL/eoSum5FBK07n/ccehuYgJVtS1aLTY4JEMaat/OQPrrF0T9jSKkMR/cZs3yEaKh/
         wFc1T2THbbpXPI+0RPOhHBY4o7Kmbe1LLgK8hfjc93MDbT/KEiNYOl3+SpDBLO6gA7PU
         OsYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950169; x=1772554969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGercx3vkdEAz0Gc46HRTj3KBzubttjIgevwNppmhDA=;
        b=Nv0SnCEvj1E03ViLsMVPWP2wy9007Zy3z0M2SnacQXYCJdciFiNBQjYG8+SZ5rHWMQ
         horLoTFoFgwwy/73BDzujVnYhfVgxCjj0XlGTVLeZE2WrMG02fJ4BEKclUEcmosZKDcZ
         TBikCiqnYHr14L72t3rToEdYQy42yp+QAH8cGdSC6Cz++9H5cRV/d3CQe09he1sEzuEX
         2uG8rLXuNUt8pHYaIAqxM1ChPl87ZqG+WeRPBT5iy8NzlHLx8pLN94HXdD/DJlCqGzGQ
         l6D3bmI8jVlM4YDR7TmYof13Hxa4baLpZfJEwlGaWsEAQ5itbew1PT191Ou4LkEoayFf
         RI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950169; x=1772554969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JGercx3vkdEAz0Gc46HRTj3KBzubttjIgevwNppmhDA=;
        b=iEHJY2APglPvA2QtsAQXta1eMJWEsl/uIVTaOX8IuxhZCNh5YBF+yZSZnChRnkDEdS
         0BGHj27bXDNhl+0AhV0MmNxyJHIOjPt8jom5ISDjP26cINQplt9J9kCOW5Y/HhAq4Mlo
         UJQS/phqLnhxOqtbAB6VGo9z0J9BsWoxGCWCpxN/fl5Fn7JmQi0gMKm3pHDcAXra6JZq
         uvUnB7AjCg+IpEsbX7L65gndAfIAfbHjm2SwEeHRDUCsTaTZIZbkrr8IQVtx0ICzqsOI
         rL/JeHhxcqJPUKNd6+Zf64xJ2w20aMLPXxN/mbwqLmN3wAHkJQSfuG/ARpwSeugKReOV
         271Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9LpeU9YZK1Y4BdWiASlFIuE1zKkIu8qbvtNn3z2kZqc7kp98qOP7hBs9k/2RDVbkOSiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzadKGD7rct2WFlngczZcVdCeuGVzaIpLVBll37I/kRa8GEoUCA
	c3+d8uRFcHcU2FsaRWy+zUtP+DVv4XafyOMrkkzwPb6cB1IRJTwkM8o82F0uLTCyn9Qd/WoLAjT
	HmNuCN+DAt6s3C23DG2UzPOFuEv34YK8=
X-Gm-Gg: AZuq6aJ09NB6QCWRgsLhlk+W6qymnSR+UmZhmOsFYJAcTOuI2NtXwp/NvcuXJqKuTfQ
	L6bbl7GgrFpp1FebddUXwCLZeuS6WmODRAMCUGvzMQtjQagi5JHZYAteXQ8gfEgnxjbThh6x7uB
	X57cTxRu5RqWu2WXWJw5zmJmBC1l4jbrLYQwf18Ls6zaOFqmhWpZleabPLTH899mowtEMZ9SH1K
	ULszB/KnyMyXxrh67nvKNKSNptK/pzl2tehdayj4eT0skTCAcLto+zM4oXsPvGmcq342fvji4+P
	Gl+WYRwGJeMK7S4lvmw2tNlEIn+h/DxaS4MqqNlNs+zzrIKFQSPxo4PkhC7W2mv5/ZjW1oh2EpT
	HI4+8UOZV
X-Received: by 2002:a05:600c:45ce:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-483a95b5835mr212494515e9.10.1771950168684; Tue, 24 Feb 2026
 08:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ2cBWyiG_fKSjIq@sirena.org.uk>
In-Reply-To: <aZ2cBWyiG_fKSjIq@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 08:22:36 -0800
X-Gm-Features: AaiRm51o_zqO5Ia2dOB6XYBIYz_d7zJjJJTNTIBgDEBW7i99NJvSUvxyxg52aCg
Message-ID: <CAADnVQKoX=Tg63QiyuUZ9aWVYUPi3-gQFCs47s5AiWKjqT=oZw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 4:39=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   tools/testing/selftests/bpf/prog_tests/align.c
>
> between commit:
>
>   05849ec34f3d7 ("selftests/bpf: Replace strncpy() with strscpy()")
>
> from the bpf tree and commit:
>
>   f632de6e19553 ("selftests/bpf: Migrate align.c tests to test_loader fra=
mework")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> (deleted the file)

Thanks for heads up.
Since the file is deleted in bpf-next anyway I dropped this hunk
of patch 05849ec34f3d7 and force pushed bpf tree.
There should be no conflict anymore. Saves the headache for us
to resolve it when bpf goes to Linus and then back to bpf-next.
