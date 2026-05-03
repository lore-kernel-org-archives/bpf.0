Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85D3A785E
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777846579; cv=pass; b=tBp4u+NuSMyYPYNHT4LhEijASG3zZj0z8oKi/tbzwS+QcWuW9uWtwnF95CtKMl2m3uyNz1sewlD+u6WZgzrH15QUU9JWOEwXzyY7Ikekrun+VjqVEANr7YuYXN7mIFzRDO4n+a9LujAub9LX45sUt3Rjbymv9Q4nBbejdd/s08k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777846579; c=relaxed/simple;
	bh=DDv+Yp+1gjtYyykJtDrlteB/bGCNRsn6zUDP2FMJeiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVQykszaNlIHkGO8ylnoXoklOLhP1eYVWF8JrGAtkGx4IRVTm4Q7SEcFcxhPSQ+B52G97CQL1hJvzbh6n6LUbF1V5rVy40yTL4rkn03eES4K7pN5CEhwRYpE80Qv/ZR984tjtea6BDZ1tlDK3ijKzqab3iu9/1q295Sb72o3LnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgrkT71I; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgrkT71I"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so64465866d6.2
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 15:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777846577; cv=none;
        d=google.com; s=arc-20240605;
        b=LZngvtT3RuXYfWiMxrlZa6wxO5Ge1XFndWfrfKZUa3co2WwXLPq0MGEpBy+WPiCWH6
         Hpk1NTNVgJjsslHxN6ryBQFtsm9oArOuus2CslD4hyjlIlwr5VgIw4qW/EqIjygi+n61
         k3Ya9uKo2zHagSZprWHe79NCHyiwLyBcvARVsk6zIcuNxooDTLat7a6r459Dk00r+8ap
         uN1hf7Yxgd4D3hkR9rIhuwSWotiyi3RKqY3GpUG3bCSLe1+Ex0RY8/uuTDQNmU60xdm7
         V5E8Dio85qZo5PaZ6jdi/xpx364JRMpxZ7787oalkLS2HzDZUosCr/JyQnb65ktfYzgR
         A1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9YHgNwnwvFtLh+4KnPFQdLMewAAtdbCTzEaWSC6xLFo=;
        fh=jMJHa9Edldvyym6Pfz/iyBtS8djeOPyJLSZf5oScMyo=;
        b=PjBeppXIeWurJZYkMTrQoNInoV0NDTmCNM2rkmpkyi+IHGB2kbCxl2CmDlv3yCSSgy
         5/OxTSW9TEcXWs2yVeLY1zeDRa8mwOV0+hlFNhFZdcD6ai1fxmUzTT04RpAaSMHb1qL+
         r05JBTAcmrdkkxscde9MCv4eLoBmI1pyo5cDWfsrF9uKVI7yz3Jo+wQ3mKpbnBwonbK5
         ES7D1GhGCJlwW2C65nOGBl+bgben9gLuQ6DUmESsMgE+VyaFtVmPOaagll+iMctk68RC
         /iccVtyyDvR2PGh76orHw6WEn3KsENPmw9iOw904FcJO9VR8FtfL+4dKbh4uiiF3HQ08
         ZnYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777846577; x=1778451377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YHgNwnwvFtLh+4KnPFQdLMewAAtdbCTzEaWSC6xLFo=;
        b=JgrkT71Iq3qm5W+eRptG7x5PWQuTtVU9K3/xv8uA1/bkJLnn3Qp9Nd3CEegVkGiwl1
         eQGKI8LNtLnHmqF4/tH1wkX3AS4qw9BpOvlCgAarSA1fEChPQJL9pH4L2iUGp0MVjkLf
         McjXPJlzpqHTdXd0/om3du4lZ4shvD+sMfu0llYQEeDt5mPf/IqXguJ0gj1kz8lN1XfD
         /GEXqQCDIyR1phC3aRoczOZNbXTM/xas+k4Vi68/WCqB7Ytxi4+WPPh74qmjtHKHhKcM
         8gWbeYQBQsk41jg/5E6o3bhjjSoR/v9e7HVA30LRBbebRjczO6atg7n1AlI/sa7PMXJH
         lIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777846577; x=1778451377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YHgNwnwvFtLh+4KnPFQdLMewAAtdbCTzEaWSC6xLFo=;
        b=psVz2HSFMRxvZ06t90m1DDiMa2dZrI860pmrZtSDPpWn/AM+t/oVeLCtAWCWvd6RDM
         0qZzB7bff/3X9b07sPYhGtUKh0O/LbVkjsTSPxuRFDchA2wuBPAhvw4XEo1qHhKPM1WG
         6ThBuWI9SLvG3volP3hzFnHUwXqtL02SkvYpylHXdRDTXOj2z/9+JtRIj/5/d4GN9akA
         786Vptdi5vtYk4SW+44rISTMQuReuhZVXgh4rX2WHnN+zX3fenI3PrxdBy9OlyaTbBO/
         7ieAt9cxO0z7jmN4DDMv/of6kX783u2r8lCQ0ULtdNts4K+3xWGmGO85j5rV4zWDULNj
         aTHw==
X-Forwarded-Encrypted: i=1; AFNElJ898j5iJHy+0q4ONiCBGSyIgXgo+8PRLPvo2fnZWKOpHzFp+zdAZcR/BLJEdutUlakGJ0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmiNVFA29ODTLXDW0mxKETTr+aF4g1ZvqQogIsLcUeTp3PIh+i
	sxbWM1IMZAp+axsheg1oM/aPfF2lHlFN/1WvYwW1yDiB+6HDd+JT/5GHPo8be7IBgpb/7pVZh55
	e8OhEf9UnKKxw7yFXS0kGuHh8CXDeHfw=
X-Gm-Gg: AeBDievCdJQuVcurrV2FWJtW8j3N0WWpMjOqZ/vC0IBbKhw8zVD4Enqvdin8Sb0j/eo
	8wt7CqpKn6n8Ev+cmharrQ1pnYX5+C1OPrY+xXAxcFBcASsZJ262g+hq/25v+qRTspJeSe89QXC
	9VzR2yBvPwLf8HTnkdkUMHlbQnfJbZRQloK96v8Y4RuGPZp+zTxdlbdg8IfpVfLC3kjR/60sGCc
	1QgIm9Cu+lTDK/c+ayum2yitfFMxQzyVkC/KdsPX2cHpwgShjAjaJVrS+9XS6adoHzn7Jw1TxU6
	AgcH9jn7ZeYjLp4N/9a3LiBY7D8Y7jiAuKs+eQeEyer4IdbEdmpoGx4nEF2te5vpEeTQ5GCM
X-Received: by 2002:a05:6214:5294:b0:899:fab4:730f with SMTP id
 6a1803df08f44-8b669cb2811mr132853046d6.49.1777846576665; Sun, 03 May 2026
 15:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <b6170cc360f0db18ceb0857f97dfaf84d129a6de55836fef2b0b604805cf5039@mail.kernel.org>
In-Reply-To: <b6170cc360f0db18ceb0857f97dfaf84d129a6de55836fef2b0b604805cf5039@mail.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 3 May 2026 18:16:05 -0400
X-Gm-Features: AVHnY4Ly4Fi0jg38_SPDginqiS5Ues80w6yOGakHcPvelfmnF7EYox0CILj7FOM
Message-ID: <CAEXv5_g9DsWCZuE0xab17eyGeebQ-2VK+7rKHJny+TpxwAPM8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>
Cc: kernel-ci@meta.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 6:05=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> Dear patch submitter,
>
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [v2,0/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode=
 labeling
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D1089026&state=3D*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/2529138126=
5
>
> Failed jobs:
> test_progs-aarch64-gcc-15: https://github.com/kernel-patches/bpf/actions/=
runs/25291381265/job/74144006068
> test_progs_cpuv4-aarch64-gcc-15: https://github.com/kernel-patches/bpf/ac=
tions/runs/25291381265/job/74144006070
> test_progs_no_alu32-aarch64-gcc-15: https://github.com/kernel-patches/bpf=
/actions/runs/25291381265/job/74144006061
> test_progs-s390x-gcc-15: https://github.com/kernel-patches/bpf/actions/ru=
ns/25291381265/job/74144145907
> test_progs_cpuv4-s390x-gcc-15: https://github.com/kernel-patches/bpf/acti=
ons/runs/25291381265/job/74144145909
> test_progs_no_alu32-s390x-gcc-15: https://github.com/kernel-patches/bpf/a=
ctions/runs/25291381265/job/74144145905
> test_progs-x86_64-gcc-15: https://github.com/kernel-patches/bpf/actions/r=
uns/25291381265/job/74144340605
> test_progs_cpuv4-x86_64-gcc-15: https://github.com/kernel-patches/bpf/act=
ions/runs/25291381265/job/74144340652
> test_progs_no_alu32-x86_64-gcc-15: https://github.com/kernel-patches/bpf/=
actions/runs/25291381265/job/74144340621
> test_progs-x86_64-llvm-21: https://github.com/kernel-patches/bpf/actions/=
runs/25291381265/job/74144264073
> test_progs_cpuv4-x86_64-llvm-21: https://github.com/kernel-patches/bpf/ac=
tions/runs/25291381265/job/74144264084
> test_progs_no_alu32-x86_64-llvm-21: https://github.com/kernel-patches/bpf=
/actions/runs/25291381265/job/74144264085
>
> First test_progs failure (test_progs-aarch64-gcc-15):
> #138/6 fs_kfuncs/init_inode_xattr
> test_init_inode_xattr:PASS:test_init_inode_xattr__open_and_load 0 nsec
> test_init_inode_xattr:PASS:test_init_inode_xattr__attach 0 nsec
> test_init_inode_xattr:PASS:create_file 0 nsec
> test_init_inode_xattr:FAIL:init_result unexpected init_result: actual -1 =
!=3D expected 0
> test_init_inode_xattr:FAIL:getxattr unexpected getxattr: actual -1 < expe=
cted 0
>

This fixes the selftest:
https://lore.kernel.org/selinux/0a65e27845468d7b0b57810086a563d3@paul-moore=
.com/

>
> Please note: this email is coming from an unmonitored mailbox. If you hav=
e
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.
