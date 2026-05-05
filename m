Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2030DEA9
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988787; cv=none; b=NRQNMWXBUuo03UKzDJqeRixTz1AvgBlog7+SxteAJTVDy27L8t6BGkoC3Tg4j2bIyLwQsdSO1aq+565Cz79Nlzk+G30CwZz8p6QhdZrOG5cqg7E9Aon6bt8J8IfZJqOYe2V83KDthA3mJwhPRF4KmCN62+CWe8W53SoFz0mumJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988787; c=relaxed/simple;
	bh=/SB9w/lu4rpLZoP5zMPyBIrox/m4yq/Erix3efeJsZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6aHxN06fGFsLRjDIPuUnvUGpTABFAMMGdPe3I8zqXwxRhxZ9P20Wx/fj5aZQd85GpQ8GmTp0dPW9OA5zT8r0NAAihMDjwSZ+pGPCoGzxO0ph5Z8SXm9dQOV739QCwCt3lrfACrRCM2ms/TWJVRhlzXTk7WP1F13P3O3K6vnnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THhM5hHn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THhM5hHn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d77f6092eso3272984f8f.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777988784; x=1778593584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BldvR/KjLpUT5P5fABoq+Uvhcs7WX2y4diGy1AvlJkU=;
        b=THhM5hHnsDjnKw2Z9uMfcbiD3ilRrmwMuBqW+ZqOOcUPoT56z0tGaesXR3apIyJS/9
         esQkkVdfIECbumkJiASfhUmkKLEqpR+Y+byvzQgzJ44RTZmkeh2AYp2V+yfpqxtjgkL6
         /dR8x9wxjvVxBV6AsAjawIkJiE6b6cT38p2FAExjhUAGoB6BB0du0Skzz6uyMumbjoSk
         rx6VMquugihIxVeEwhKT3ynVhqLisIi3jgxB5e+V6XZ7vP5zkcg9QVR1zclIc+xkb9E7
         FsYpQC7a5qqSoQ8H8u41yV1ZYD86avvJ/caAbEclMlaJS2x1l9R1XzY2dI+mmGmcFRPM
         r4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988784; x=1778593584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BldvR/KjLpUT5P5fABoq+Uvhcs7WX2y4diGy1AvlJkU=;
        b=XXVO6n5kYRFLLt5H6AOCbL3XgwMWjyLiTu5QEraaeWQYPdydpSlKsUONaILBDTRTN/
         C2T+wk5bqElK7W0Xq6YLdfWMKtuTTdQC1kQxpbKpVc/CNWBIwiuR+/rJxRWten47Xt+X
         Y8EQHajmbiHvArrIIMuxMjMNqquTi2jvwIVoJ1WV/0p7bYY89JLDtZkK1IZ6NEFtpYQ9
         izta4ob1RnMbTljQU8G3hPh5QdSnj9vPk89pXCD4DnDm1oF02HnVu5/N7aJ1ob1v3qM6
         8QMcay/kdt9MD/CRLaVdaC25HGdi4p+DRIF1xAOv/NRW+8vPeiJBH0N8dec7X+dWVNKF
         ybBg==
X-Forwarded-Encrypted: i=1; AFNElJ9FgnJFwHWooZ3CpOL/0JB3QvVJBcOI2/ypDJW+ryGuGA/bi0QtBXGBhKRB2c+vaojw8Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2J9aDuYqFFwLy3P/wsG+5oQeNYsHczn5cQGLgQ/977hJdkrU0
	nsZwQZcDOgQOpCG+7ftzlVhtmubO1XS7gEDTgF+a+e1RJ6uNoTsXDUN0UaZr6Qgf
X-Gm-Gg: AeBDies5/a9qEyEA60N0QB22GU4wTSjAAWJIog8SEOeeP15BQpP6NUIbSOORsGydtW9
	HwzxGmw46YJHZ1mLgRXQwV/JWW3A9LycqOC/tcHl2TaUfL5lmI3iozjUIMnS1f88fSEOQLfOkPB
	bvc6hLokzNl6YkQJGDMf1vhGJ0KtkC2XkmtY/4tCSGa+74VrQUqlqur+U9m4nPt/TKTj6oIzSUC
	qWUz44wj5wC67PWIPedV74WpcozNanpp4XyJc0+0x81uuVnaLuSIGJTFyiyIx31XrAzY1b1iO3y
	/BVHF3qsym49w6/lJ9jtgtMv2Jrv0xqXR9LNLCrF3t8CF7+NNCdDKsKt0UzY/XG75Ok8yNE1mB8
	uL5oVJBJe5lQI7DMSh7DkSxhOGCyXG6PwCyk1XzeZe7oZ1UtYXHEue3LfydM3hX1GC+MC6c/He7
	16TaAREdgHTgETBsmYlaS+uTy1Hwbs3k5ihG0G8ZpbIui+RDnqlhRuWDl61a7RpIxNtqHbMkR2B
	CxM6rABW7QIjEaS6fK9BQ==
X-Received: by 2002:a05:6000:2484:b0:449:9aee:4573 with SMTP id ffacd0b85a97d-450043993camr6193613f8f.18.1777988784196;
        Tue, 05 May 2026 06:46:24 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02f76sm4482703f8f.23.2026.05.05.06.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:46:23 -0700 (PDT)
Message-ID: <ba47c5e7-b543-418d-bc25-c5d1c6f1e59d@gmail.com>
Date: Tue, 5 May 2026 14:46:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SECURITY] BPF task_work context confusion enables cross-process
 bpf_probe_write_user() via token delegation
To: Keshav goyal <keshavgoyal1744.kg@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>
References: <CADb5NHh0-ybPPCXbXEEye2uN+0fu1g4zq0QCRvrgJmoLHn=y9g@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CADb5NHh0-ybPPCXbXEEye2uN+0fu1g4zq0QCRvrgJmoLHn=y9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
Ask your LLM why this is not a security issue. 
Mine did well providing the right answer.

It would be a good idea to do a little bit more due diligence 
before reporting issues like this.

On 5/3/26 3:28 PM, Keshav goyal wrote:
> Hello Linux Kernel Security Team,
> I would like to report a potential security issue in the BPF subsystem involving task_work scheduling and context confusion.
> 
> Summary
> -------
> A BPF tracing program can target an arbitrary PID using bpf_task_from_pid() and schedule a callback via bpf_task_work_schedule_signal(). The callback executes in the context of the target task, allowing bpf_probe_write_user() to write into that task’s userspace memory.
> 
> This effectively turns the helper from “write current task memory” into “write arbitrary target process memory”.
> 
> Impact
> ------
> This creates a cross-process userspace memory write primitive.
> 
> I have confirmed that:
> - The target process can be root-owned
> - No ptrace or same-UID checks are required
> - The write occurs successfully in the victim process memory
> 
> Importantly, I was able to reproduce this not only as root, but also via a token-delegated BPF loader in a user namespace (using libbpf BPF token support).
> 
> This suggests a potential privilege-boundary bypass depending on deployment of delegated BPF capabilities.
> 
> Proof of Concept
> ----------------
> I am attaching:
> - PoC source code
> - build + run instructions
> - screenshots demonstrating memory modification
> - logs showing successful execution
> 
> Key observed output:
> 
>   scheduled=... ran=... err=0
>   BUF=AAAAAAAAAAAAAAAA
>   BUF=BPFOKAAAAAAAAAAA
> 
> This confirms that a BPF program modified memory of another process.
> 
> Root Cause
> ----------
> The issue appears to arise from the following behavior:
> 
> - bpf_task_from_pid() resolves arbitrary tasks
> - bpf_task_work_schedule_signal() queues attacker-controlled work
> - task_work executes in the target task context (current == victim)
> - bpf_probe_write_user() writes to current->mm without validating origin
> 
> This combination allows cross-process memory writes.
> 
> Environment
> -----------
> - Kernel: upstream built from kernel.org <http://kernel.org/> (latest mainline at time of testing)
> - Architecture: x86_64
> - Test setup: QEMU VM with custom kernel
> - BPF features: BTF enabled, tracing programs allowed, lockdown disabled
> 
> Reproduction
> ------------
> I have included step-by-step reproduction instructions in the attached materials. The issue is reliably reproducible.
> 
>  I was able to reproduce the same behavior using a token-delegated BPF loader running inside a user namespace (via LIBBPF_BPF_TOKEN_PATH), rather than directly as init-namespace root.
> 
> In this setup:
> - The loader runs as a non-root user (UID 1000 mapped inside a user namespace)
> - BPF access is granted via a token
> - The target process is still a root-owned process in the init namespace
> 
> Even in this configuration, the BPF program successfully schedules task_work on the target and bpf_probe_write_user() modifies the victim’s userspace memory.
> 
> Example output:
> 
>   scheduled=... ran=... err=0 
>   BUF=AAAAAAAAAAAAAAAA 
>   BUF=BPFOKAAAAAAAAAAA 
> 
> This suggests the behavior is not limited to fully privileged root contexts, but also applies in delegated BPF scenarios.
> 
> Request
> -------
> I would appreciate your guidance on:
> - whether this is considered a valid security boundary violation
> - recommended disclosure process
> - whether additional hardening or checks are expected here
> 
> Please let me know if any additional information or testing is required.
> 
> Thank you for your time and for maintaining the kernel.
> 
> Best regards,  
> Keshav Goyal
> 
> IMG1:
> IMG 1.png
> 
> IMG2:
> IMG 2.png
> IMG3:
> IMG 3.png
> IMG4:
> IMG 4.png
> IMG5.1:
> IMG 5.1.png
> IMG5.2:
> IMG 5.2.png
> 
> 
> 

