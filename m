Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAD35AC08
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639516; cv=none; b=C623YpA9UGj+0lbtz/dWMHMX4Br79An6MTyaeodqhgnMkhS709HOFTlshaNh4TqBRYh60fnJ69m1oGbKIySdawZ0McLbCZ1oX0QJA0JR0/NgBnUARD/yghxu/5hWAyoIN78Kw6oBpocPc/kXTJZGQ+WWKjoWIBicQkuLxa0EBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639516; c=relaxed/simple;
	bh=5ZMjekRXkTF0z/iCnuoeODu/fxct0ji/qztmkBY/S74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMMmSTfZmtuMpNu2yM22q+bZWDD84HNGrAvX9am+UKLGlg7y4W+4dMPd3MNcCQ/JCiMTcMhfHOFqUBvQiqjnhT2vM8HxBYYUbOR0CogKGbYbAHRY8gTWl1nU682MdYHxg+b0jeIidAA10x9kHDk3v5bzTlChJ9GA3s2Ajlxbgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D73aG3y/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D73aG3y/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae5636ab04so34333975ad.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639515; x=1773244315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biF8JF+x7wlDuvH3bE2Hsuz9zAy0Y4BOSyInAPcrCZc=;
        b=D73aG3y/NqfX1+q4ak+gD4Jy+0Fkp7hW7TEgPnsPIjaIIZCC1/GYFrBEwc114LWtPI
         nz2zjxsW0vHUuDxhnSknRnZGPgXgiX848JAGbVM1HRjWIGD2H34ghUOzA6tcmzoX0+4n
         8EYjvnCu8FXD8CWNrc0khXBHXWu8GIZtGi8ln0PdFs43gwKkZTS3YFvrSkDZzE/GR+to
         yOguqur9m4lK/75sQJwyGjNJEgN4W+ZiyADtKR5bU3mxRpBSm0jm1jSNFDNM59XtexQD
         A94Wz76hzc1P/dOjPlb0tJcMYjjWsIOs1RSU/fLAQd9W8F5qXZme1BWEzlZss3l1r/Zc
         G3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639515; x=1773244315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biF8JF+x7wlDuvH3bE2Hsuz9zAy0Y4BOSyInAPcrCZc=;
        b=eyOmuUE2G6CRM4njezHWY2++v+d9KPju25tM3UC6n/x4NoPf/IA8/Uhg5ExtEFXesx
         TUxIaRT3l+KgjLvxLqsXuglfLQfzPNLuVQYp0AsVERasxAmc3lY/MhgCLGcP7rEMa9ET
         3PkQWwswASMKekGPCBWJsy7EkLT2+NJklXFGL797KNE6JShRAD9CvCiI4f+IG0whb1t+
         oDOcay0s1n1UazV2/pkBIuFD1zzlBJM5b2qa0rfCoenP/mJs6wlKcAd0vHmxcSce5hJE
         cGIZGpN0U8t4dMpYlRSyVRfNhBuEfoErSYfM6RJS9XF9Z7fkOUVCbsEBCVpNi8oWkT0a
         vIxg==
X-Gm-Message-State: AOJu0Yxd0upS7KnJACcwhi92djCOy8MtuFH/GcDNd1br1qYdE2wjeAFm
	gtXHreANoSjhcfNft10xeGJZaHr48sLuaIx3iC6yKeOEhwMfpuhRfm59
X-Gm-Gg: ATEYQzxMIi8KN7fjDYDn1EbqRhkm5Wu1wkNYLhKGtKErUolxm4ZiZh0vtSk/1v2zwG6
	4u4dVsZUh1A2+zaQllWYHg7f5pOS2Fi8NgYC+O3FRichS+b27CKi301ZlV9ZI2x8rfojXq+WpSe
	8TW7Qx/GzgFNHDgs1GYXAquIi19zT/PKRfDzSRLg9kJHMCzWC/3+YZH9NXJFK8FALyDKKbOxBaY
	nMZrgu976L3AEVoqheQ1Vg9UYu4TsfnKjAGU6UrbFvbqPoeS4T2gkUidIk6B560Rw5xJ4GvNTK+
	Ai5+pEbE3eHcC5Dl+TfxXmG90etaH5ycoytcD9gOTYiXwsZHtAnC7hLUkdDCq++9k/K8E0qpuac
	v9lvGdyix/goygNzdO0fY6xcvj07cYXA1KlN/lgsDErQ1laJtpG7Z0zGG4eEbnOA4vAqTk3aXMS
	FWU+3o+5NCFeLo1b8ea6jVVZg1XaW/L6PVZooz
X-Received: by 2002:a17:903:2ca:b0:2ae:557e:1f7d with SMTP id d9443c01a7336-2ae6a9ed626mr26021975ad.7.1772639514642;
        Wed, 04 Mar 2026 07:51:54 -0800 (PST)
Received: from [172.20.10.5] ([117.20.154.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae399acba4sm136890835ad.67.2026.03.04.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:51:53 -0800 (PST)
Message-ID: <5449f387-1141-464d-a206-172b4d54363b@gmail.com>
Date: Wed, 4 Mar 2026 23:51:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] bpf: Extend the bpf_list family of APIs
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304143459.78059-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20260304143459.78059-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kaitao,

I think you should wait for some comments before sending the next revision.

The patch target is missing in subject: [PATCH bpf-next v6 ...

Thanks,
Leon

On 2026/3/4 22:34, Chengkaitao wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> In BPF, a list can only be used to implement a stack structure.
> Due to an incomplete API set, only FIFO or LIFO operations are
> supported. The patches enhance the BPF list API, making it more
> list-like.
> 
> Four new kfuncs have been added:
> bpf_list_del: remove a node from the list
> bpf_list_add_impl: insert a node after a given list node
> bpf_list_node_is_edge: check if a node is the first or last in the list
> bpf_list_empty: check if the list is empty
> 
> refactor kfunc checks to table-driven approach, and add test cases for
> the aforementioned kfuncs.
> 
> Changes in v6:
> - Merge [patch v5 (2,4,6)/6] into [patch v6 4/5]
> - If list_head was 0-initialized, init it
> - refactor kfunc checks to table-driven approach
> 
> Changes in v5:
> - Fix bpf_obj leak on bpf_list_add_impl error
> 
> Changes in v4:
> - [patch v3 1/6] Revert to version v1
> - Change the parameters of bpf_list_add_impl to (head, new, prev, ...)
> 
> Changes in v3:
> - Add a new lock_rec member to struct bpf_reference_state for lock
>   holding detection.
> - Add test cases to verify that the verifier correctly restricts calls
>   to bpf_list_del when the spin_lock is not held.
> 
> Changes in v2:
> - Remove the head parameter from bpf_list_del
> - Add bpf_list_add/is_first/is_last/empty to API and test cases
> 
> Link to v5:
> https://lore.kernel.org/all/20260304031606.43884-1-pilgrimtao@gmail.com/
> 
> Link to v4:
> https://lore.kernel.org/all/20260303135219.33726-1-pilgrimtao@gmail.com/
> 
> Link to v3:
> https://lore.kernel.org/all/20260302124028.82420-1-pilgrimtao@gmail.com/
> 
> Link to v2:
> https://lore.kernel.org/all/20260225092651.94689-1-pilgrimtao@gmail.com/
> 
> Link to v1:
> https://lore.kernel.org/all/20260209025250.55750-1-pilgrimtao@gmail.com/
> 
> Kaitao Cheng (5):
>   bpf: Introduce the bpf_list_del kfunc.
>   bpf: Add bpf_list_add_impl to insert node after a given list node
>   bpf: Add bpf_list_is_edge/empty kfuncs
>   selftests/bpf: Add test cases for bpf_list_del/add/is_edge/empty
>   bpf/verifier: refactor kfunc checks to table-driven approach
> 
>  kernel/bpf/helpers.c                          |  98 ++++++++++
>  kernel/bpf/verifier.c                         | 103 +++++++---
>  .../testing/selftests/bpf/bpf_experimental.h  |  39 ++++
>  .../selftests/bpf/progs/refcounted_kptr.c     | 182 ++++++++++++++++++
>  4 files changed, 398 insertions(+), 24 deletions(-)
> 

