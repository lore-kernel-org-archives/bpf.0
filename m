Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4A3C9EC2
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145722; cv=none; b=Y/r9icNuYuIcbElltmgsrHPbyB4usqHMD7BnnM8I13xQFZUzwYy6b12zuNnuRBmMAyCGrwoA7C6YPSzveUkwyC2d9CoKRxKv/2ffcqfxEw+iqE/anvq7uDFnW599TnVMlXMDId46xUoxmPTh/F6nclG36MR7YeA6a1wD4Q64uKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145722; c=relaxed/simple;
	bh=ziEQMgEt6cFWlyD+Y8SF8ydZXv730TVs827bnSESCP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiiqxCDmZCYhiRimy6cg4cFn85V/yoSPyZ7cTmYRc0P5k6SPbgIdtzqfM3foQYdAHsN2gL5lTCPt/HoNy2S5zl1Bs9z2dvya4P6U7P0MCxS+vvVH1eDI5fSo/1fgI89l1PbxSwRG4PxyICECE7+9eW8xOd2M3mgx1iEmLM+ZMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCrbUEYE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmhJizYd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCrbUEYE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmhJizYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773145720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NE9w9NeJUlvy56dU7aps282nSTS20Xf4YKmb2h8N6aw=;
	b=BCrbUEYEwaIVjFH2JFuJ5RbN4gEvSD7PAsEaO13VqkxSXx73+9QxzEU3DjASSHHCekmObU
	gSp2zLAEAJEEEIhf0GLH+h6d9347SiVMak9WUv6VTpIAOWUaiigrMnMsAoWPV8wE5U6cmF
	B1KkDl7RAbuDGb3LZWy8jCjCRSmv0Lc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-7BlufARuOCC5PAaAoItpxQ-1; Tue, 10 Mar 2026 08:28:36 -0400
X-MC-Unique: 7BlufARuOCC5PAaAoItpxQ-1
X-Mimecast-MFC-AGG-ID: 7BlufARuOCC5PAaAoItpxQ_1773145716
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-485375aa56eso19145085e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773145715; x=1773750515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE9w9NeJUlvy56dU7aps282nSTS20Xf4YKmb2h8N6aw=;
        b=EmhJizYdZn+HECUY1Zld2iv9HrBt2FC9nEfxF5ttvFCaw9hCFy/J8h5CPeThoW8bW6
         H7bsr77uLlve4J6cVFY7BRDINsxPV+gyMXKVXsltBgM+aeaXO8/mSOYadXUokK1jH7XL
         o2dARg7XgjZqFKJt/oBOGABUxlycq0XEddbqDB6RLMHzY6oCts7FnyGONPRHeHOWkmGR
         JDqIjjcLEe64HHft12qaKc+WkMenJsbAcNgiAce6u8SKSA3NMU9DgDyPscEgudfhoXkl
         oUB+3WyZjiyuaJw5fQAymoGCz/wSScIvlLvyT1zTlUVphlVdXPx6mpULqm8U7gkYCxDm
         L6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773145715; x=1773750515;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE9w9NeJUlvy56dU7aps282nSTS20Xf4YKmb2h8N6aw=;
        b=UwsrCtW+KzX9fiH92iitU4nXgnQ71m+1nAH2hzhZNmnHIddJIM62BKdAcR3EXFKFe3
         HALswONuF1rlceLKmU7dOIwLkLTi3cHXyIX6ZaMAYR2gm3LJJETyIzZnM/YX9cWFb2yq
         GjrV4Qrx6bcIGRpMcrchYkLtgV4tsb9k74U7l4duT+JK+eN34hlEzgcH4uOxBQaIxDfi
         vlLuxHbZvMzMlOzvDaloSddgeGmQuhC6P4+F7eMfehUSLsIze/voWN7nD0uUy5GFBFmq
         Sk/EL/Cxt+huLU/hnyPhsn0ws01xlguG96/dErK2rI0KlVRwYWAxOmmpi8iK7xxdHBKJ
         Eg+g==
X-Gm-Message-State: AOJu0YzvVeS343DQ8t1r8MeTuMRb9DBWZ46TEJHR5rKk+JBQMJVLPJao
	bRZS7awMEGeltlxcZblbOgS3IS9jk4CMIHOgTys+MQLSYVcCzcmCOI8xqqIllO0eO2PUI7Y25kd
	Dcb1RCGGm1vOMkM9SX6b/aiq/+XnT62HRi08tsPYoDPRKT4bswb/A
X-Gm-Gg: ATEYQzzzzUTqaknwPfZ2MQS806oXB3fgwMzfTMDGrCDKf4u7Jev7bcyfRgfjuTHeZKd
	hM+t8Ts+BIZcPe0TkgBpc2MvKsj6SQoCfcLg7HMEBb5L7PzzwvEQzGG7DwBG6NIGURealZnIt7H
	teyLq/a9vQ54p2bwXuNsmH9Z0xhPXykhN9XwBmRZgwf0BR4L6xtwakCRG8fYkAOss3EASPm5KaY
	4q22pLE37dSvnFVhT6ADOft6K8QEXs4lVifJiDEMAIFxja4DzhGjqh41YbS8vDKhB6gtFDpIz9k
	EQ9tzUsiE8w8NgBhJVLGZmV8bEzYNRRxrkBvW4iTk8nZOz7EKqtiJYo+Wj1WQOwKZezcGGtHiOc
	vfheVHo00XA==
X-Received: by 2002:a05:600c:470d:b0:485:389b:ee5f with SMTP id 5b1f17b1804b1-485389bf08bmr137552215e9.2.1773145715570;
        Tue, 10 Mar 2026 05:28:35 -0700 (PDT)
X-Received: by 2002:a05:600c:470d:b0:485:389b:ee5f with SMTP id 5b1f17b1804b1-485389bf08bmr137551685e9.2.1773145715088;
        Tue, 10 Mar 2026 05:28:35 -0700 (PDT)
Received: from [10.43.17.131] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485419c2930sm124103475e9.0.2026.03.10.05.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 05:28:34 -0700 (PDT)
Message-ID: <6a914824-178a-47c3-98f7-f3c3086ab831@redhat.com>
Date: Tue, 10 Mar 2026 13:28:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/bpf: Fix read_iter buffer termination in
 test_bpffs
To: Sun Jian <sun.jian.kdev@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 11:21, Sun Jian wrote:
> read_iter() always NUL-terminated at the end of the buffer, so strstr()
> could scan uninitialized stack bytes on short reads. Terminate at len and
> use O_RDONLY.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> index ea933fd151c3..e8021ff0581c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> @@ -17,11 +17,11 @@ static int read_iter(char *file)
>  	char buf[1024];
>  	int fd, len;
>  
> -	fd = open(file, 0);
> +	fd = open(file, O_RDONLY);
>  	if (fd < 0)
>  		return -1;
> -	while ((len = read(fd, buf, sizeof(buf))) > 0) {
> -		buf[sizeof(buf) - 1] = '\0';
> +	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
> +		buf[len] = '\0';

Does this fix any real issue with the test? I can see one very
hypothetical false negative when the uninitialized memory would contain
"iter" but that seems very unlikely to happen.

Viktor

>  		if (strstr(buf, "iter")) {
>  			close(fd);
>  			return 0;
> 
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681

