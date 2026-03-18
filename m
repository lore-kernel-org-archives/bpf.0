Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DB2356C6
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773798828; cv=none; b=FwUoghse/Ffq70PoJR2QQwLy04rDioK5uZfW3nGPFKhwLLS4dD370oHFLlwQY+9mAZAx/XQnKz/n1SyTfHZq16c5fd0gX53qN8leIH9GSvGrQXz0dN4TwpkCBSc4T91FWNSUcDhyLPRdNp8QmTkdRKG5DDZEQlWTac2jUBY5d/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773798828; c=relaxed/simple;
	bh=5pxaOMozqi+U1L9wQC+eh3K99tLwoa1nEZUEmGVk9j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t48DIwv3TvwSRnT0HNTedEydKzW0L9aML+iQfgsrbKXm7efzlxaGXf/Xt9PeUMpYxCPMRecauCN7ESQLXmeIRXZ7J2+7HGxZx8ydNlFnD4xM+CygBLJnE0gY9KDyRC4mNqxQVzRC86KTrnx/iTjebzpTCpqtsbUJ1oNsudbSz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WkMSzFdb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WkMSzFdb"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7412cfb9eso172675a34.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773798826; x=1774403626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sgb5BhT3xmKc+VcLKBubloVcdYOT6b+LpfgZfEBHMG4=;
        b=WkMSzFdbF9G8qFmp7JZMOkSyD8rAArZpj3qMcYFYdrqqtitop90bwfyTU06AdcQkVT
         rvTUeH0jDrOMwRKVudDGLYU2tFmUQ5z64/jXMYhFPvgnv3UP2LtZLGj3vUS99Ki7oQbm
         0eg4GWeHaCWCASvea3Hc4W1TbEikeioSZyA2S3f1kybjfwasVp2ZI4ORs7agBilPSC94
         X3my9fBqhAKa9KTtGIaNTlZObc/c+xWhQQivwCG+UKWw6e8YIFjIAQ5qzGbfp0HsqUKP
         Z4T7eyfup8iApiKiYhVeO9JiFHCgDlAF2J7No6pjswe+4Cgno9iiN3R9SOZen6xqEWao
         hKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773798826; x=1774403626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sgb5BhT3xmKc+VcLKBubloVcdYOT6b+LpfgZfEBHMG4=;
        b=hk08EH2ypbT9ilPrq2F4Qf9SulVrYwBXOxAlTo5a+EOFhhDG1h1cUaDFmAWJkOaz3K
         y0/i4yIbj6wJ+nH6OXPOvDZGQjYmxnHHSIUIZ0y2FoqyTY+GC2rj1yT7ajhjSd6cNzTj
         W1LlsnZmEtKTpM0NBJckqI1P1ySWAGa+ZARkdsDn12XDvGhGaoNM6IbBBhHzY8QlnxNO
         N8BXuCKPQ++v8MgK8B0+WYl+JDLojfJapBEPJ3yYv2VQZtmi/giLOCNf5WGAvDNFjXs3
         J9NX+wCZPkNHDO2beWBCTfL48L3vURMe5ECmpO/WM6iwomBpEhISAsBHgy8K37aoLI0t
         i20Q==
X-Gm-Message-State: AOJu0YzBeWSgp85yZecEZgqMXgMHhccqSEuGisuMkYDsUajfgp13n6Z1
	hYuZCBjh+cKvxtcISm65Q3IpjLWeJ/SIdzjFEeFyfFys00KBcpjXvIr+giDEAV5siOM=
X-Gm-Gg: ATEYQzw7tgqkUUkYzirBdGjJpdJ4PTmPRHTqnjYTbNvPbWQKz1M+SlpUwDkF/97f9D5
	LRKR5eyje0kMwznv+Q/q3FaD/fOCS0fsebXajUhCv5ophmXOzJTcO9GSogPrCl8usbpRM/CIGBD
	9EML1YsDBXc6AhJnHuAP4G7Wduw+Z79x7KFzo1ySUgShV8g1aYKqMTPBcQJAGm+jRM1BXDKav6Y
	udnRR9OZ1JeDvtIKdSF0rIGYAc5ZMDBOgfM+nLwoO+ZMbOuks5wdSKumFN+OpfbkYD57XooMyFy
	JZWw4GInIc7Z5l1WErOgqabJo2/noJl7kAXtr/A63/xhJQZYFrdKk17feADe0Om+kE9jGcUcOll
	CyKVaRD67PLi7k9nrw+uR8AFI3hw5tvCFARSdlJBVzet+odN4DBW8tFDlNABg34m/kJqEusr+0p
	aM3pQ3ETBCQnRV2uSlwEU2wVbUtvMWcCzAWr/BjlAByjlWr2zvyt/kFyEdlE58zM7+N4u3g5YU6
	Mgfagv/ng==
X-Received: by 2002:a05:6830:498b:b0:7d4:96c3:3f97 with SMTP id 46e09a7af769-7d7ca566cf8mr1223594a34.2.1773798825772;
        Tue, 17 Mar 2026 18:53:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b3696asm1102397a34.16.2026.03.17.18.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 18:53:45 -0700 (PDT)
Message-ID: <9f08ade1-ca61-4ba3-9d1e-744ea5e8c004@kernel.dk>
Date: Tue, 17 Mar 2026 19:53:44 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH liburing v2 1/1] tests: test io_uring bpf ops
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <818dcda223b3288c764367cb0ab8d57c83722d78.1772109275.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <818dcda223b3288c764367cb0ab8d57c83722d78.1772109275.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 5:49 AM, Pavel Begunkov wrote:
> Add some BPF struct ops io_uring tests/examples, one is issuing nops in
> a loop, the other copies a file. It needs appropriate tools for bpf and
> hence is gated on a BPF_TESTS make flag for now.

None of this ends up getting compiled... Can we add a configure test for
this too, I suspect most of it should be there already in terms of
liburing supporting the cbpf filters.

-- 
Jens Axboe

