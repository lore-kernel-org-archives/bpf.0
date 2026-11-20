Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202651;
	b=5RHs2s027rPwEb3zhKsSXc76LBnzAXBCbusOnWrVdAcG6STzxLJeIiRZWQTjEa34L225
	 6zCDuzN2nsJVuorqExpDdrHtM1XerfMpBnMEUGr5ZIm81GUOLuOJ9qS0gxOHN+tg28/jJ
	 RQEyxoooF6hXses0l3ufYaoI7sfvvn2gcAQfilL9zwXO48LBym7XqlIxCUfEsW8hZ9WPV
	 gS+QBpwpDAWuPFl77d9bgcgSqj9upqYwhlj8Jasj+IlcFPgYKuN55DwKao+tjyTJaehBz
	 uXANZMyTaZrXvEv6668U4VaKMQEFPpfR6/pZD4UZF6HcB/l20fBlvQ3HMS6R6w/axEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qHo6CdyCabm8XH8aUppzEr5dak8Hjpei/j+QDqjBmtE=;
	b=217exzPaW/aludjYi0zS+LJM0iWtiRF6qLEuDUsnzA3b/LZVwVF6njYiFswpJtvGBAM/
	 TqC4yb/VByed8lJui81lsMYmc8ZsFwKhj5gHzaQDzoOPQC+nu0BMo+EN/yvg4e9Y5ORxQ
	 Shm21iMVuJGorj0nmzy+jWwpVjEWRmJQIN2+AFohsLTK01RjpWuzcvAhylab+Di2o98UF
	 RMYqY7X2YcBdwi1MaKBGbUmtW11nHnaybjKW7w6mS16SnBSe+WsNIGnmp5EIj5ugr7AqI
	 v6qlIHds6+1dITKSe7vlUm+7W6kk9WwUA1lsvVHxl35OcU9ZMs1Kzy9aIR/LzO7rZtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=MWX3rqdu;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17A606A6D4
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C17A606A6D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=MWX3rqdu
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a358881793so700877f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795202649; x=1795807449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHo6CdyCabm8XH8aUppzEr5dak8Hjpei/j+QDqjBmtE=;
        b=MWX3rqdub2/YZr8awmCv4sB0tcy8MHCXgd/nQ9Qka8sg9rdMObkifriYyu/68Pf7T9
         9NHP7i1U/6cGX3M7BxhI8rAnPJ213jGK186ZTspzL0EL97GSkkd5uhNeMn/jo71E0MC+
         opCDBFvJ5Ovww+WSm018f804RJubnFFJAUTrJgGhxsg/s/QMtaB13mYZx6Hbr2QAdZJL
         Bi1DC4t1adzP6EGUm1Z5b5fRWMylX8yBQcU+a0A5BhAHfNkyetgqiDBBr/mo1BzyznAa
         2qJUkjU4xpeCnetqQ9wNT45LJhhlgmjfPfxYZtHEa/tCnC82kEK9aKKGyu6vAa2TNZ2a
         etTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202649; x=1795807449;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qHo6CdyCabm8XH8aUppzEr5dak8Hjpei/j+QDqjBmtE=;
        b=0jnqFO7ip9kEQLYTdJ/q25sUYqixDpgBR8mhoLxImBv9k/W5MYdvLjj91qecY5hbLm
         i0clJaJiHDOH0yyO1rsdck+iWbOjSCAyeLzud3+KJd71aLYThV7xnNB0NaWV/6pu904b
         0AV+Gkyb6AQT136OmA4NSRuPbR5CQ+aewSp/PsB9u3N/XxYnMVLx0OSlzZHKWJfe2kDk
         +nAWRIGDcImMYrSBu3SdoCkxsCgIsrU5J6a1IMtyqwHntRTDgD4cDv6NYn0hreG+Go8T
         XD9eRzchF/TdfxtDdcoKlmZNZN1sdrQvgO0tERoyncPOXX6G6cr9cmhUydDysKV2+HQy
         D1iw==
X-Forwarded-Encrypted: i=1; AL+hErGnWDMIhoOhg5PsxauYbx9C/+GEtMkePLeHJyfgvumDTeIehJjb3j3SHHYLcQzlyOOtK3k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ukXNIX2Erf7fyMqFAW5hKpSnulEMhuzgpcVcghZ1bFy63JSAw
	UWRVEFJIO9Gjc/t2LD7XwVRgVThZXmvQvEDCntjYtj9NWHJHisk5X1TGTnhTNrD0sTk=
X-Gm-Gg: AYBFou2pwBh/juCm+g8cgo/rmwZH1HOJUJjJzE8aDsP3JPP99KQIiEI4PN1UGPafn5S
	mm7IULf0dwgBg+0s7+V5B7WY4Ndpuh5SSzebZ50LBbm/T2veKezwe+KcgU2ZtlGMxbJLP4izVFf
	9+lULA1qHOzC9ykb8sDKp3J7kjcS3zt1lqnrpXcWcGzGrL6HIRAVfp8J3roJB8xfh+IyJOh67Xg
	z2WVnepDyGdJ0cOy9SCkrRv/+9cf1/pQWrZsaswtSfCADYjY8n259V4fnW1u2SwO5eyKqgpEGdO
	UmH8LEpcNcdeL1ns6rO2Nja5W23pdnajPr1oIsvL/lgXLvkroJPKHAxuuAEL57D/Uhzc7jvq+B/
	lD1eRSByEvCnQa39bLQ1DekBR52N0e1vBQ70DXI6lkGFux5Ts6KTFaWGZi3PGl/ceg3JdK4oQqy
	ukLTMg3kJs9FLPgW+T4JeG/VFmIuGbhx3h3mleJNsTaZN2bQICf29sZ1fJqz6BwkfHhcIxtQn10
	Q/Du0VuyFSbv3XAOZLrrbgI0D+8TAi7klbJbBy1wy+xB8nVf+TFFQc6X6ZQVTd5VK00CHq+3dJ4
	uJ8uMxWs0W4AOrb/meU4hQTwdVFmdy0a5rkxvb6OWMn1BBgenGIIEKX3yNI=
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id 5b1f17b1804b1-4bb8882432bmr91151435e9.25.1795202648785;
        Fri, 20 Nov 2026 11:24:08 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm36376085e9.2.2026.11.20.11.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:24:08 -0800 (PST)
Message-ID: <27bfa146-0512-4e35-9e68-fbc8c50ef405@blackwall.org>
Date: Fri, 20 Nov 2026 21:24:06 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/8] bpf: add bpf_sk_assign support on egress
Content-Language: en-US, bg
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Joe Stringer <joe@wand.net.nz>,
 Paul Chaignon <paul@isovalent.com>,
 Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>, netdev@vger.kernel.org
References: <20261119142231.2612515-1-razor@blackwall.org>
 <DN0A2SUOYS26.1M5IXC6G41RLL@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <DN0A2SUOYS26.1M5IXC6G41RLL@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2026 21:17, Alexei Starovoitov wrote:
> On Thu, Nov 19, 2026 at 06:22 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>   .../selftests/bpf/prog_tests/assign_reuse.c   | 625 +++++++++++++++++-
>>   .../bpf/prog_tests/sk_assign_netkit.c         | 586 ++++++++++++++++
>>   .../selftests/bpf/progs/sk_assign_lifetime.c  | 182 +++++
>>   .../selftests/bpf/progs/sk_assign_netkit.c    | 153 +++++
>>   .../selftests/bpf/progs/test_assign_reuse.c   | 174 ++++-
> 
> 1700 lines of selftests. Pls dont.
> Tell your bot to make it absolutely minimal.
> 
> pw-bot: cr

Yep, sure I fealt nervous about that, even though I've reviewed it.
v2 takes a simpler and more narrow approach anyway, so tests are fewer
but I'll try to keep them as concise as possible

Cheers,
  Nik

