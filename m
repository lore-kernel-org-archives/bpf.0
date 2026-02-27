Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD5264612
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164456; cv=pass; b=SM9c76jJbXEnniVMA5r1ICK9pAoDcbQZZVj2SgHjC8FvDPAeMTt5o3uaqCWF73S37DOiFRvRHD/2bwkA/b4AfbB+sDkaOA7In29UJa3I6mUXtKBxPPgDQOxYm77bNbIdoimtb74ghLWr0IjhedM4DoRGA2JbMB6jXNWaLGQu6SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164456; c=relaxed/simple;
	bh=jJijzHap0JGImoD27IL10/VtI99BOtUcqpTp77rZf+8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NqP9ZaOlEcEAtP8PBy97HE4EGT94g5XjG4YK0UvjiliKWveqo+mcxq9prK+c9J+hgalefDbM+eC/+OF+UUDLD1EHH1neAw7NC0kHsBj2YUkqnN45Eb0O3kw9zBHvEen6afD8UBtorajXLnuOtTZBYgNfw0AgaB6KvLZUpE7cWwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm1lTMOd; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm1lTMOd"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ff05af29b4so540016137.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 19:54:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772164454; cv=none;
        d=google.com; s=arc-20240605;
        b=Bf2bokrPVc7ya8hY6fGMqhPQJQbezNi+wP2He2a1Js4qTFYlqBvZk8yvzgVkmOjGni
         x2o/K/G7ldU4PGpIEJhDLzKBF6m47+1wiBjKlq24ONSatw9bZjjkHRLsv0EUVk7HIfLu
         IBUkio4raQweAmSQLq+c1AobE9sOWc77v5/1W1X9a6cjBf/wy+tnGhwdJDWn/lg13TKH
         UKglRnEBMwSYlLlXeXBYGrkydL9sjEkmzwZgdaS/Ixl4ciuFEWFj3Eu0mqBZfs2s6G36
         06IXxwEgeGNYZ34QNMq0vVOigCgXCu3RrIDHxtfgE5S+IvHl1f2sOcSA9ejBrYMO/++4
         QxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=tAd5Covs0RWq0co+6JwfGV6yUXyHXa3uqZWmZYq+Hm4=;
        fh=32dRk72DdPZCJ5/pymtr/YFdnppT/YFkXw3Ba74g2Xc=;
        b=RxHHRg+gzm5B8XMpHsT2ie7EQ287+nHhIUHTuThq64jN3BnkEsdjabpdbMYhc75plC
         ZJrPjd02rTnRsy1dZB4HMXwSzLUwlCHsxPt6PfN2e34qr0A+ze0yBhmK1Ax0xsp/BIPi
         pr/u7a7sFMQliRRf5mkGqlEo3OhKlaV/+6o4coLMRX4NKbHFf+TEl+dCxue4NSRpPO8J
         kt8sFlPyADNbhyFKUj36xNc96VuiFvW9//Vw2X1Cjoy/looA/my3oMyR6HeOaTxOYKYU
         rlzhhmiETzd+vKncAmeSHpka7qqXtK5EYUaPzgXeC7YI0G26lAeZPWUZJG6PI9IZsbO3
         wDRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772164454; x=1772769254; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tAd5Covs0RWq0co+6JwfGV6yUXyHXa3uqZWmZYq+Hm4=;
        b=hm1lTMOdjmyZcCurLvmT6AIU6y3oMYaYWG1SzN0kl1wYRl4tWEd2e1A7S/BQcxy6zN
         QEoEHazhjcpjfORolXhvAFQGmZJhKk6EKxSZ5DT17yCVn39LjquUhyRpx5tIo4cxqEKu
         QPxSUc49PmHwcU67/46ZagWtLPb2hbMqX1Y4FG1ipgFtf0PHY9/EOeO5ftAK95QGdh6Z
         tOUR8fjuxOic2S/YTM46mvFh3WAxmryzhlmPxitA4Xumoe22ULtuqhHclT1jtXpl7pEo
         NISMXGEBRIA15KuYubJ9wlQrsNZASZu3JDDWjQwoaKYZlxcetv3m1gxyhvT+V3Ig8JNd
         V4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772164454; x=1772769254;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAd5Covs0RWq0co+6JwfGV6yUXyHXa3uqZWmZYq+Hm4=;
        b=bX10aycq6zV6+vTpKXG3kYDlNJL/k9O54Qi8+pUMZpIvVVft7E7bvo2YbjIwLo2ckv
         soPr1Odikyqh2WMDCk3GnDd27K5TXDV1/4iwYWZ8ihDwy9Liytq9X14cIfAaD6ZfXJXR
         kCmxzDJiOAa8UHIRMTcQONpXfSxkxIghUZNPGHTqxz8VQVblo7zrs1Sw9uKHk/JkpII9
         2g+yWITqduLDBBIw5I8AJOrOw/ZbTkcSBzsfS3G3h8muSHkBRzXI5u7Qg/+rdkZmOUFQ
         j8iCs4yDveCfD/djbxYxf+ki2xxD7/zlvKAT/mB5C920OM6TbCCyD2xPb2aoRkdV/QiB
         jkxA==
X-Forwarded-Encrypted: i=1; AJvYcCXpz87MBr7hSS2rJZmjV0crvP2hgTXZ2dYld+p22Y1sSasPijpNA3bzVf7A3aKB+fsXgjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6v6Tx2Fb0cg02xTHW69q77YIuPr2Qo8Iwn0IKoCnwktJcbDsh
	EpiraqJYz1Nzk0xe85f6TOq/7ZQEIsJLeompJ6q06zH35Z5vVgoU5o+pxjbLy80ewJST/1lBJiW
	ItwPqvVOPXP78f057YP2WB9I4opdO6Ibwi2ExM5ZXUg==
X-Gm-Gg: ATEYQzzAIgTTt5hLqmVE31WcDeloOfMTLXx+JWfEeMQWFxXeKJ5H3O0dPpCqCvSAuIm
	MSh1DF2KW0Cb3MX91AkU6BcXdYqZnbGk0tfze9Z08ofYw1cg1YLqdAWFxwljyzBsRUmiWfGx7Nk
	WhBcR3qmrH11jnvgFVxNQnDl6Id/i8mVflnI+513GkqpMbkz01yRts4ezHkeBahNSC46JRb1dEK
	GxrZUYyC0n88eQVPUSiRm6GslZHVjXbXD6FnQ0YDP462xFNAgU17MNKpd14htAcvK+DtPVbO6lt
	TQdonZ5V2X4aXliSM24=
X-Received: by 2002:a05:6102:3753:b0:5ff:256a:3798 with SMTP id
 ada2fe7eead31-5ff31f9d35cmr746411137.0.1772164454251; Thu, 26 Feb 2026
 19:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 27 Feb 2026 11:54:03 +0800
X-Gm-Features: AaiRm50MRpm26Nb2WrltvVRfHItU03U2cR7fH7Erd1DKoeri1dmoPo-D2GUiJm8
Message-ID: <CAEyhmHS+77CpP5ph2yOD4hs72L4697Q=-UefkkHvryvcmWotPg@mail.gmail.com>
Subject: failed to gen skeleton for verifier_arena_globals2.c on cross compiling
To: Andrii Nakryiko <andrii@kernel.org>, emil@etsalapatis.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I hit the following error when cross compiling BPF selftests:
    libbpf: elf: sec '.addr_space.1': declared ARENA map size (131072)
is too small to hold global __arena variables of size 524288
    Error: failed to open BPF object file: Argument list too long

The target machine has page_size=3D16K (__PAGE_SIZE=3D16384 in vmlinux.h)
while the host has page_size=3D4K.

It seems like the current libbpf implementation does not consider this scen=
ario.

The following is generated by AI:

---

**Title:** `libbpf: false "ARENA map size too small" error when
cross-compiling with target PAGE_SIZE > host PAGE_SIZE**

**Description:**

When cross-compiling BPF selftests targeting a machine with 16K pages
(e.g. LoongArch, arm64) on a 4K-page host (e.g. x86), skeleton
generation fails:

```
libbpf: elf: sec '.addr_space.1': declared ARENA map size (131072) is
too small to hold global __arena variables of size 524288
Error: failed to open BPF object file: Argument list too long
```

**Reproducer:**

`verifier_arena_globals2.c` declares:

```c
#define ARENA_PAGES (32)
// max_entries =3D 32 in the arena map definition
char __arena global_data[ARENA_PAGES][PAGE_SIZE];
```

where `PAGE_SIZE` expands to `__PAGE_SIZE` from `vmlinux.h`. On a
16K-page target, `__PAGE_SIZE =3D 16384`, so `data_sz =3D 32 =C3=97 16384 =
=3D
524288` bytes is baked into the compiled ELF's `.addr_space.1` section
at compile time.

**Root Cause:**

In `init_arena_map_data()` (libbpf.c), the arena capacity is computed as:

```c
mmap_sz =3D bpf_map_mmap_sz(map);
// expands to: sysconf(_SC_PAGE_SIZE) * map->def.max_entries
// =3D 4096 * 32 =3D 131072 (using host page size)
```

The check `data_alloc_sz > mmap_sz` then compares `524288 > 131072`
and incorrectly fails. The arena map's `max_entries` counts **target
pages**, not host pages. The capacity should be `target_page_size =C3=97
max_entries`, but `sysconf(_SC_PAGE_SIZE)` returns the **host** page
size, which may be smaller.

**Expected behavior:** The size check should either use the target
page size or be relaxed for cross-compilation scenarios where the
target page size is a larger multiple of the host page size.

---
