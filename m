Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA54279DAD
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258563; cv=pass; b=M8vhU0hxwHB1H7vdYBSAdyKPh6KCroD2a0NySBwZVH5bKkZu5GzOLrUs5W0ERbw//a5h3XD75rBSspuSDWs4ErZILMJTu4MmqUCC+P7HQ/XJSHCpZcUhsKhFPoN8TEHuQFm+EatvhUFQ2S2nn2PkYFBhkU9XaCDt5ZVNvHr8g5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258563; c=relaxed/simple;
	bh=hnXTTbndB2cu0GYVbMZ41U4ltR7ppd6XQcgRax05Llo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rFeC4Hxc3ZbLRrSlbFOlgKVEHdg57JvUWA0YUDYl+ThDkeWNc7/uhMLZhvkM7pg+fhKz53GoRdeHU1nJR8Xqvb+FIJwZBWfWtJDfnNeMGc+xTnW+sqY3nz1DXzjGh1EhOg1tN/kvL/4M4btYigDpQ5BaEM+1ZgfpPSGuqXtOkHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AeMMg7Bj; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeMMg7Bj"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509062d829dso670501cf.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 16:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775258561; cv=none;
        d=google.com; s=arc-20240605;
        b=RSaawco5gHZIhuq7hsWKOFLRJ7GDmVLNQzLZyZq3I8vvogQdKLh+IwZ7QFH7Ri51H5
         oeaVD+xPxHcLnNcSJmrXWTd444EFW6ZfBqyl7AYFOMPfAuBi8cuBvzhm4lSEfK6z9xDQ
         zh5I+HIprgb9mvsKjOgoZpsNJdfjKnVDmdAt+UyGnHAb+obbX6HXWHefSAXRPivMauG6
         ZPUrBQAe6NB4iVH38pdk5hwYoHhTTqUrRGfNvpe/mYxW7tBenyu3YqXoyYRoZzIUS9qa
         kHqRUryOhZt0zgluPgX4JEC0P2KMJVk5tQIsCc9G4Ft07Tal3tzAEUMIoeAzBhS7AZwr
         zSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dJREsZcFCG4Z1TkFROpVY31GKK4pQBd/gB4KqzJ1jrY=;
        fh=uqaL384xlqIhufY+QlBaOhCoitiHE0u7DfsWh+Afqfk=;
        b=H1t2Jaz0ZcNPucklZ8t7JiYuSBoQs2XA4sJK+w+8qQz9HMEW7T2ZPb4dZ2/O0ftrg6
         HHZLLMgOkKpsuDbKs/Yx8epvIV74C9KsNGSTumxSeWto4O4Aio+BS0t3dttDijLkPg5Q
         HKpGAod4EB/je8msQcpWcvfehrMu49RRAqoaM6pf+Ki0Zod4QN9+ELfQWj5371N5ptUp
         Ppd0qlbP4BefNq01vv6KS+OC3GOnbpt7b1rUUyLCMvTSU0c/TGtlRt7D2e2sSg6tvkdU
         Msdf8B6GvZuSdR8D92Cu6e/U2q4XjxLWIQ8n+ffLZdZVsXSZhNdfQq9Me/ylBSH4DWB9
         Q9uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775258561; x=1775863361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJREsZcFCG4Z1TkFROpVY31GKK4pQBd/gB4KqzJ1jrY=;
        b=AeMMg7BjnrkS8nSQsrKFxuv85AQirNzxAcNo82FYuBkuyeGT5h2siNWmnRB+oCpbH1
         B8PQEFOeeoObSbVPbmLw4ib7ZOUTO45TULzEe6r8aYl41aC563GUxF/DE1dEJpTSNGc6
         K222JL4FIl1ixZWO76YxLdrO793UEI2Rilrt0GmJ8lfHPHk+MNw5clTj9U3xWo83af7Y
         oYJXyfV1gL/CQJv02UOA0v74A9ejJblwzlFpfImM1MwGunVQkOt0sMqD8COCpYWLAv9n
         4kqWnXUUvBruwDxA7CZRPVhyZt60kIbiik4G6NdJfSTXoebpXrcVe3wtSnqUaa5fq4vr
         p9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775258561; x=1775863361;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJREsZcFCG4Z1TkFROpVY31GKK4pQBd/gB4KqzJ1jrY=;
        b=QTew/yUqX1jLDI7W7YipFaeA9VU/pNhPGr0wzJA7yuNBBN/srZd5BvgRxmbaZrwQYH
         2S7bcAioieLYgRRQp+vbJQJ0OnuoNI53viSrngX6DN7P2ZKcOxI42ozazwZbajlqtiJH
         TVaLvT8tzhX0CIjba8rPZLt1Kbu+s1F8km2DvKW1NRi8pgvrDy7GnI+YFbqgWznpBcPN
         YlpBWrmzYboa+xo6s2qXWXbXBRNGprvpulRIQQk+14qkLD1ZYmGP3P7osY91GiLx5vdo
         FXF00ejJSxSZbEkf13kN+Izug4n/wiVV3TI2iUszDf/4peueSjtVt/3BIadIBUWhHCXu
         BlDQ==
X-Gm-Message-State: AOJu0YxxXzCIg4rCnS42O4iWygHr41qEZe6QEkTz/pTxkBh2m9/zGUAJ
	AIeDCic28JvckX88hoI2dID44s1fFtg2vTR8Tv2Apwtm5G+HuMMFA0/9XEqnKXytEZCVyfwox/W
	1mFb8Xvejz8X/aJGia8LumnRFHHaHmVCG/LdlIdWMkEZ0GpkHBoi1+OE+Jqg=
X-Gm-Gg: ATEYQzxQjdj/xZHZqD7VI8YlJqntOnXHZmYhamgy48eJ3ANVxedWO9WRZNphnMGN3D3
	FR1xPubXzssFJfCBH46ulms80BhoAAC2cLKNPnGCDUaaL6eKOHGkJpV0SUUxb1WE/JswWnpXVnf
	i32R0A1F6xXUG0PyzZbusHPrPKkWMQ/tpJlxiad3KDoBfVJEOQeVPyt1UIJcUM03MjDnQhxZ91N
	E+dSPS/AU1ziNq4eOcKGv1n4J7Mdx8PXlNZHDdY/bWVi4zLNRbxKIiboPtHqTcBFqkmUH77VLfK
	EzefmWACKXlgt0m/XSrX/A1/gO6R5hPyxtQZ
X-Received: by 2002:ac8:584b:0:b0:4ff:cb72:7c03 with SMTP id
 d75a77b69052e-50d6634e939mr15723691cf.3.1775258560592; Fri, 03 Apr 2026
 16:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 3 Apr 2026 16:22:29 -0700
X-Gm-Features: AQROBzBaHEQwD8YlXMUrryZePeW1bkNU5qRVOaShSABo0KmSqD7DWc69o8IVzgA
Message-ID: <CANP3RGcL+LFNBk-+9Z5W+8Nyj1+rxCkgR=EiQiLdHW22dSKvgg@mail.gmail.com>
Subject: bpf() system call writes out of bounds of user supplied buffer
To: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, KP Singh <kpsingh@google.com>, 
	Neill Kapron <nkapron@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Took a *while* to track this down, as it then results in random
memory/heap/stack corruption and segfaults, but:

kernel/bpf/cgroup.c -- __cgroup_bpf_query()

       if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))

doesn't verify this is in bounds of the uattr + length passed in from userspace.

I *think* there's likely lots of other such copy_to_user() problems,
but this is the one that bit us on upgrade from 6.16 to 6.17

It was added in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/bpf/cgroup.c?h=1209339844601ec1766f4ff430673fbcfe42bb51
bpf: Implement mprog API on top of existing cgroup progs

But it seems to be just generically bad style...
