Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCAA18E2E
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560246; cv=none; b=R7XU9VDug8OgVe/TnXmGOEkxQPKMXSvA19B+xy6Mu/3wSfsySJk5Eql3oJkQTeTdlG1u/HrzLszGxKQkvP9axsFaNuw5HIp+356vR4dgSw37AcN28EZuwn6YFtv2R2k1w7UjqU09vkdjRcz4X/tThIlvNbujov8UHXSHvartBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560246; c=relaxed/simple;
	bh=a4Nw3gtNqy/ogmCDqjQ7u7fMAekq1xunaaLaFVF+EuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF9Mjll6iOkaEt1pl7nLXOJXc2tfaxDoAoISumVzRGVUXLdf4Z5HapQfOR33QwbSCkOWI34gelBfzdGEoRNFDcSmRGT+2nrpp1cumGuk0tGFbK3P5iFbfC/N9hRH2NlCXT6613NEHR1UNQcPiHRtWPpE3SEexNTrZsSLaanfa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=F0DlGd86; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="F0DlGd86"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d36736d4eso2778625f8f.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 05:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709560242; x=1710165042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24vfr2X8/Sh0e5V448kXBABPYEm7WcswM63DS9FBF5o=;
        b=F0DlGd867RgUpO/xhF6kJtvxpTW2V2RU0GNDlCdNotra1zNS4FOtXlWlsPyqCa9RoU
         6IpMweAD24ynqa1iiznIKHLJ7Aq4a5EG7vRN/54ytkpsy58R1qdQAdY01u8OR2r0jlR7
         DQX4yMGZ6Ddg89LfJqaJsUhkKLrwk2WP11gV+4XHQKx29RKWG5ADVUY6/ilUdff+E3lM
         OvXqbnzfZMTNmVJ/rSnscIqGN62W3GsDobzZyMhcve76IpcYoW0a4eo9KIQe4im4hMTu
         nQQnsY5XfYNPbgwoa8aiPu//cj1U9j0UR6yIlearCMR33oQPo2n0nxmAwuETfT2ZfJGQ
         6slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709560242; x=1710165042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24vfr2X8/Sh0e5V448kXBABPYEm7WcswM63DS9FBF5o=;
        b=jodzf7B3HhpG1t49FqxFSRp7sSi89AFv7Vfk72rYktgWaUYczUKuyXJj76pDNsUreT
         wHQwAjsrs6+vApZ01PLepTvAawbWWwkqyu0wQ0QsG6P+hw7yEe8Lha0XQT34w+lZTRbW
         sBcHO8san4GggYH/9pfFGPsIdxFdyvJ1EcDg3kzQyqpCG6ldkCAtIKWUfHTQBW2fkQ+s
         x46pTZ12l4B3b4fapL7OGQm25zjEn3RRhTVJ9PWyZFP0aHOvJNLMjXQtsrwPjkYknPIe
         mtfFD/G+x5J5tz1TpHfi3zAB/LnWyKoNuH3t7q+xdjKf+wjbVhJ8wGUDeTq49NbIJgZd
         04JA==
X-Forwarded-Encrypted: i=1; AJvYcCUnpdIFDrfEpQFa/czNVlim4bkqWTdf0idfSuWhalgZ8D+LvOrtq14GiiRG5SSyzu4/sUgA8mHTJ8z0QT7Pwohfzwqz
X-Gm-Message-State: AOJu0Yw7D5+/2qvPROteSwzImfdMy1gdlY/wdbmZA9sau0kZ+BNULzYz
	xruqwhzpffSUvVINoguz72t1IVjaHvJKtlGgec0t5yNbr2jWoScf5pnH7zZNhBQ=
X-Google-Smtp-Source: AGHT+IGhl9Ph6pjG7k0g1tIKhaVuCBUuMXcZiPwELyv+1Dg6QOvBYdAKbZnnGQ/WW1ZJS2Yb4BYTqg==
X-Received: by 2002:adf:f64b:0:b0:33e:9d7:5dc5 with SMTP id x11-20020adff64b000000b0033e09d75dc5mr7844002wrp.67.1709560242391;
        Mon, 04 Mar 2024 05:50:42 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:5481:1a6:7def:4b7f? ([2a02:8011:e80c:0:5481:1a6:7def:4b7f])
        by smtp.gmail.com with ESMTPSA id g3-20020adfe403000000b0033af3a43e91sm12295951wrm.46.2024.03.04.05.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 05:50:42 -0800 (PST)
Message-ID: <2aeecee4-3499-4036-8c26-59ccffc2c6ab@isovalent.com>
Date: Mon, 4 Mar 2024 13:50:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of
 parent dir
Content-Language: en-GB
To: Sahil <icegambit91@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240229130543.17491-1-icegambit91@gmail.com>
 <d61e8537-e291-434c-b401-2b020b2b610d@isovalent.com>
 <3290360.44csPzL39Z@valdaarhun>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <3290360.44csPzL39Z@valdaarhun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-01 20:28 UTC+0000 ~ Sahil <icegambit91@gmail.com>
> Hi,
> 
> On Thursday, February 29, 2024 8:29:07 PM IST Quentin Monnet wrote:
>> [...]
>> Perhaps it would be clearer to split the logics of mount_bpffs_for_pin()
>> into two subfunctions, one for directories, one for file paths. This way
>> we would avoid to call malloc() and dirname() when "name" is already a
>> directory, and it would be easier to follow the different cases.
>>
> 
> I was working on these changes here, and I have got a question. In the
> description of the github issue [1], one scenario is when the given directory
> does not exist but its parent directory is bpffs. In this scenario no mounting
> should be done.
> 
> But to check whether the parent dir is bpffs, the malloc and dirname will still
> have to be done.

Yes, true

> In the file subfunction too, the malloc and dirname will have to be done if the
> given file does not already exist.
> 
> If my understanding above is right, should the mount_bpffs_for_pin() function
> still be split?

Splitting the function was a suggestion, but you don't *have to* do it.
What matters is the clarity of the resulting code, we want the function
to be easy to follow and to not mix the file vs. directory paths too
much (or then it's very easy to introduce bugs such as the existing one,
or the missing --nomount check in your v1). Don't focus too much on
malloc()/dirname() here, just make the logics easy to understand.

> 
> Assuming that the function is split into two subfunctions, there's another
> question that I have got.
> 
>>                if (is_dir && is_bpffs(name))
>>                                return err;
> 
> The above condition was added in commit 2a36c26fe3b8 (patch submission [2]).
> If the function is to be split into two subfunctions for dirs and files, is it ok to
> remove the above function entirely in the file subfunction?

If I understand correctly what you're asking, for files, "is_dir" would
always evaluate to false so this check would be useless, wouldn't it? So
yes we'd remove it.

> 
> If "is_bpffs(name)" returns false, then that could imply that the file exists and its
> parent dir is not bpffs, or that the file does not exist and no comment can be
> made on the parent dir. In either case the malloc and dirname will have to be
> done.
> 
> On the other hand if the file exists

Note: We handle the case where a directory exists, not when the file
itself already exists. If the file exists we get an error when trying to
pin the program.

> and is part of the bpffs then this condition
> will allow the function to exit immediately without doing a malloc and dirname.
> But this can be determined without the condition as well, since the file being
> part of the bpffs implies that the dir will be bpffs.
> 
> Thanks,
> Sahil
> 
> [1] https://github.com/libbpf/bpftool/issues/100
> [2] https://lore.kernel.org/bpf/1683197138-1894-1-git-send-email-yangpc@wangsu.com/
> 
> 
> 

