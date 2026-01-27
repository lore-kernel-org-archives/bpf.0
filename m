Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7D1F9ECB
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556202; cv=none; b=KL3MvBWTj/FXbUugN7FgxEPRplWMXQv1jyqCpSdV72Ae4hI+scnTDYRNj+Tov0063Yz0EMqsHceQ0nDaFH9HOL8PdLhVoGKMXE5RNaex3dcRhT1/omAY0UXBZ7gN4MfDuEhqaX/x/LMTMK7gicvQBDgMIza2t5Vy/cQ24MpeLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556202; c=relaxed/simple;
	bh=GGGRF5b0IL+NdiczXKcTtJJeF9X29vTuU0b+h5dcBPM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hIf16YzATk3Yb3Lft69C9J1pRxjByc39Y2DzimSKWOCibO8zOyhJwK8hNL8XG5aq8Q2o5o8mrUZo4rtcX2MJvj10qBzgFNXVU0kmGl9K8Gf0/VYTbzwmwKMft6ATpCYfkYqEAye9Fdkk5St5Nrw0VFKhQESXMkRqImlsyR8JxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=MjZPJK9y; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="MjZPJK9y"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c6a822068eso862182185a.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 15:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769556200; x=1770161000; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffKcESBHr63rAKUI//0XZ7R69KBhed/jXC5BRffAjqY=;
        b=MjZPJK9yQZyAmsveZdMCZnyc3EwVTOl4EWHECvB4Z86CvgWLUFcY0yvHbMe2Xxi4bd
         mFSHMJr4tX4m6C7dbnBrzM5QLuohpzlVX80vigMUACQyYGZE7VTfhZ2GXvVCwxg102oW
         kj0s/VX1uHeCom/rqoFegFwWyczp44pVF3BQj0TyoexeJYUztdK2fUE0Fax3blGGeNrh
         aUwpchTQ7NMXAEH8tHkb8MDetozHSPvTe3Hxz55SxDYwtnHXybyAx1MzszdoSpnUgPsp
         6++1TVX5xgtmdR+IWR5PWjyuuDoOQOHM1GYyXIOWFwm+gxwoqWsiotEQwnxTktHDgCjc
         MXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769556200; x=1770161000;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffKcESBHr63rAKUI//0XZ7R69KBhed/jXC5BRffAjqY=;
        b=mcauaikmICZyou8e7hAmTZG8qmyFi1YZ97Lp/q10yN3SyH1jXJMhswbOHoNuDFrUdd
         1UgOKI6B6b52nkNXSCe3zu8cJuCGGFoy0KOmk9ylIaYjR9+0hA0dUFmmZJvhNqLzyrqk
         N/hWDkSC9Aqm+wBy96puPt/L2VoCqeQBop7nDOLjnt4SgjPx4245JaIy4VmOFvpFF9I9
         7s5PZXDjTCpWjoKry6/6roOoOQ10eyUWKjg84Dyt9/3SKRwDsN+2qjZW9tEgAgeMvnqe
         cFSSs7OlZcLGKaGkpVAy9hmQdoevfnzWKlR1oYCFzEan2KbEOYto5O3vbTfaXIKzMp7i
         YngA==
X-Forwarded-Encrypted: i=1; AJvYcCVQSp9VAXtzdv9Z8J6RXAXNKDxX0hdAeMyKPKzPvmD55d/mWh8i8jxwOeDQ85ikIWlazmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiY/0ArEQvBgKYl+uNjDMAVWmDbMQmLyDfpcW+uFe6H9k8apjK
	uF04yYtkshi/tqa9Tgrd2GBa6w7tndZg3gkLyjdrGKatL+EfCWjpknZPAl0CaAMj3LC8hcxe7nC
	sEog2
X-Gm-Gg: AZuq6aJerbs9UMS5r4VhvuXcZATku//wdDNjM3tTjftxx/yhgzpXjPaIMDBcR4CvEIO
	7ryL99Zk+J1fJCkqYhckWA843TEYySUdTmHmgXoAsNdamRQ0lZIvYb6fEP2PNqEjJzuOQ30WiMv
	V5xzzKUHN2d1uhmZXJVCeVjZVLfjuzRQGI3bPsFkZfdB4obza8ye+o0sR6h5OveMBXHoj/pCf6H
	AcTmmz6ZMmytOq7k6S5mkZwIKpRgrg5o0k9JI7lLxJLNcCXeNhndDYLkwgftLvyWmwxoX1juVuV
	325Efn3DgCTljniXIq7JrXkb7wsx6O2oHLg+U7am/usRZLduUziXtt/B5smVUGn4OOIJ/Z3lXeK
	0d7Jiy0qj2f7wp50Ri2AF6qChNS0fM2CKRqyUGd3iD0MHSZpdPWP415mQqH5XfFYNeYL7Y8f4dQ
	uAxG7J7VlGucM=
X-Received: by 2002:a05:620a:284b:b0:8c6:e0c5:7bb4 with SMTP id af79cd13be357-8c70b8f9290mr479278785a.47.1769556199980;
        Tue, 27 Jan 2026 15:23:19 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7d169sm67834685a.4.2026.01.27.15.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 15:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 18:23:18 -0500
Message-Id: <DFZRBIX35W7S.1QXHSSEPUF6CV@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <etsal@meta.com>, <ihor.solodrai@linux.dev>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <puranjay@kernel.org>,
 <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 01/13] bpf: Add bpf_stream_print_stack stack dumping
 kfunc
X-Mailer: aerc 0.20.1
References: <20260127181610.86376-1-emil@etsalapatis.com>
 <20260127181610.86376-2-emil@etsalapatis.com>
 <8fa34825-ea90-48e7-82c8-00cf4c7375de@gmail.com>
In-Reply-To: <8fa34825-ea90-48e7-82c8-00cf4c7375de@gmail.com>

On Tue Jan 27, 2026 at 2:17 PM EST, Mykyta Yatsenko wrote:
> On 1/27/26 18:15, Emil Tsalapatis wrote:
>> From: Emil Tsalapatis <etsal@meta.com>
>>
>> Add a new kfunc called bpf_stream_print_stack to be used by programs
>> that need to print out their current BPF stack. The kfunc is essentially
>> a wrapper around the existing bpf_stream_dump_stack functionality used
>> to generate stack traces for error events like may_goto violations and
>> BPF-side arena page faults.
>>
>> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
>> ---
>>   kernel/bpf/helpers.c        |  1 +
>>   kernel/bpf/stream.c         | 13 +++++++++++++
>>   tools/lib/bpf/bpf_helpers.h |  2 ++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b54ec0e945aa..c30a9f68af6b 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -4562,6 +4562,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
>>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>>   #endif
>>   BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
>> +BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
>>   BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
>>   BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
>>   BTF_ID_FLAGS(func, bpf_dynptr_from_file)
>> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
>> index 24730df55e69..6e2cbe5f34e7 100644
>> --- a/kernel/bpf/stream.c
>> +++ b/kernel/bpf/stream.c
>> @@ -245,6 +245,19 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, c=
onst char *fmt__str, const vo
>>   	return ret;
>>   }
>>  =20
>> +/* Directly trigger a stack dump from the program. */
>> +__bpf_kfunc void bpf_stream_print_stack(struct bpf_prog_aux *aux)
>> +{
>> +	struct bpf_stream_stage ss;
>> +	struct bpf_prog *prog;
>> +
>> +	prog =3D aux->main_prog_aux->prog;
>> +
>> +	bpf_stream_stage(ss, prog, BPF_STDERR, ({
>> +		bpf_stream_dump_stack(ss);
>> +	}));
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>  =20
>>   /* Added kfunc to common_btf_ids */
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index c145da05a67c..6d8ae3887618 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -343,6 +343,8 @@ extern int bpf_stream_vprintk(int stream_id, const c=
har *fmt__str, const void *a
>>   /* Helper macro to print out debug messages */
>>   #define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
>>  =20
>> +extern void bpf_stream_print_stack(void) __weak __ksym;
>> +
> Is this needed? bpf_stream_print_stack() should be available via=20
> vmlinux.h, shouldn't it?

Good call, I'll remove it in the next version.

>>   struct bpf_iter_num;
>>  =20
>>   extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int en=
d) __weak __ksym;

