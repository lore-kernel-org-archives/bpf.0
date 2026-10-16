Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCFE4E8DE0
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166414; cv=none; b=cow8nV8S+ho6kg+DCM9jxxZzVr/uaa1By9QAxRUdjAV/O+YaNoxb8hnhfE9yFfam6PFowDQzdBBTtWTa8d8EaLsAtT02eRJDl8HOoSysTBy1hEKk7x5kwKUF6xp1CrhwVyEum3IGSR2T6OIgdoAtlKYepha23EvoQOIcfNqDBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166414; c=relaxed/simple;
	bh=Wty0OV+1GGkLBl7z+yw/+NJ1l3us2vNJiHRVs6nWAt8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=YukCGqzKe/aeTY+X2BynOmmbdtkZZXh7l5I8gMDFg4IJrqxqrz1pToQyHMqVydtjoebvei4ShzXKw4zOIJXhZKiu20KKR56Bs5s2IE+WCHYch/G7M04juxtBJfFNUcJTM4RPlU0EwsIq1URP1kmEE+s1Ib+xDikJFksM4hvirJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3Mrv+kw; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3Mrv+kw"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-823545ce223so2504931a34.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166412; x=1792771212; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wty0OV+1GGkLBl7z+yw/+NJ1l3us2vNJiHRVs6nWAt8=;
        b=p3Mrv+kwH6hHvqD4qpuZzBG7/G6cOnLof5yDAk6aRC7ilUMZtBX6cv3xbrTe3dHDsL
         YcEG1NKguKwfdGdURODN2RzAFPDp99HnnNe8ctYntqKZDnTOopJ+7Kx2coGXbAkmNYIO
         2cIlrCAmfLY5t7+l4E4KXx6UOA4GSO/7LR3b9kSmEW1odZ/oFpPKbxx8FlmSCkCvsmHj
         7RaqbCpf05h1amB3ZU/gxWyZ1F5i7oSWBtwTNgLjdKTYuYeQBA10QoKpEwjHiDJWVTOr
         IddsmoPx65/EQWyh1yR1RGcqOpeODBtC3snNxWbvDMCITPb7ASBgIIrtsE7RhMGxUUR7
         p+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166412; x=1792771212;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wty0OV+1GGkLBl7z+yw/+NJ1l3us2vNJiHRVs6nWAt8=;
        b=yxiWLJkTpwWDeSRC3Vo2BHCB7X3ZRFN3ep4mCNmI7JWja6UVOMxltnhVnRhfFuq+4Y
         v0CkV3wNRTflzdnDKGrR0FjfXFvXXI7+UGE5+Tg4pZ8Nsw8fahfy0Z0tzY/gu8HV3gxy
         4F5ao/MCOTqPqvhrjjCKQPzoqgAS0BeJxCZAA0u+tp3FX9VoMtknRJ8gipZL007199Wm
         BB7RMU7F7WIPpUNPo8/E5fXi2qtiURHfByD0xjgEdLQ5DU9+BDHi6yzjhtZaUByIbaXE
         QETXbyskjyoORe11ywp0YfpVHQ6/6riSLMu0J1Z9HUW/7WCTdA5ggHZt7j6ViJyU4s46
         709w==
X-Forwarded-Encrypted: i=1; AKwUvBwFMEmUWQ5SsFBB8u1kalKhTR7a5psUnqUZppHSXl2ilepCfFkgg/yWoEbjUPlS5VXZ5bA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+pkGxQBYA76ePvlcRV8LMuxb985gDWJwpzhwWOyK74jiZE/F3
	wTHLeKc8uoz1fPyYkKFolKQ8ocxRTp3CbdVA2n5sUfB2FJTj6BbjPVIC
X-Gm-Gg: AYBFou0nuLGIOpHQR0tI4iCc0iBq8f+KieOr6iHWKeX0tMwwLwcZJt6TZqg6wwBfIfB
	wTdjCG6PPO7SZXcPXDcPkzDq65+Q1QgqQMJtZjivXTKceY+fk8Vymxfa33Un10FERmyAOQy2JHG
	wfBLMtHAvFjOK3fC1ZMxF7e8ONBw70dBU3Z4PycYDdRme8HDkgPTQDr4o0z+7rz4pECwxQMZd4f
	eWOwrj27IaP35KsAloqfD5Fq26nQfXYufrdu/0QPtwJ6O++xQBqY892rcssMCv9DjHCqGOx0HHR
	6DDGxs13ujh5FDAdE1eN96BKAfcP5tUnM7/XdvWqi7uDbU4tfxAMp46WNefiSl4SIAJaFRKHIVM
	xpnNJP7jbzptnto4hf+JkWCCVO2nLGrezAOTnYnnMQIH+tagC5U2CeIiaelTTjg+VGpoTYH+bdy
	MmWzdhyx91Z2sIxzy3OqlNMkdARlSzeTtzpnBfIFzKM9Ivuq+i3KLRVWKNTTKVwTj1BMj3efijv
	6gvKRQ4NFpcQzD4+HPUvJjQce/8IxMoSytoTmDoggT3YUWvtyyybCGgp3ppjo5cvy3phtdB113n
	qLg=
X-Received: by 2002:a05:6830:6a16:b0:81b:9724:8724 with SMTP id 46e09a7af769-83095937caemr22112007a34.11.1792166412123;
        Fri, 16 Oct 2026 09:00:12 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6358dfdsm2097359a34.20.2026.10.16.09.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 09:00:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 16:00:10 +0000
Message-Id: <DM6DYYV4XVKO.G5S77C0FGIYG@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Follow up by-value struct and
 __int128 argument support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <a420e9de-4546-4be8-9fc0-d9e9c9fa6fb3@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev> <DM5X4L58MG5M.2AK0D6DRZ5ERF@gmail.com> <a420e9de-4546-4be8-9fc0-d9e9c9fa6fb3@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 08:50 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> This is not enabled on s390, right?
>
> Okay, I will enable s390.

No need.
I meant that all users of LO/HI are x86 and arm64 only,
so it's dead code. Just drop it.
s390 JIT has no bpf_jit_supports_stack_args(), so with clang that
has stack args tracing_struct_int128_tgt.c won't load there.
s390 can be a follow up if there is a real use case.
