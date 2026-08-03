Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2520338F945
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784471; cv=none; b=jsOKL8Vzp8NeLqlbsNJjXP8RsE7Y/SA+aLpRYFTJCFtoxZUN4vai9x/ncNkOkOKevNtt/EgppzMqE/LzhPk20o1aZm4dJ9QfbRl1SzZmjZalTTiFL84eJtb0pgBVxCL5Iwf5gf/F7I7RfQlq2xC6yPvZLgEe7XJrlMBkNdG1dKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784471; c=relaxed/simple;
	bh=9KSbiGVVYKU93vLwTvYSSfP2Tu15/HNk/7REk/scI6M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UY2rsqrbbEPJ4kNADYVja8bRk6jrRg7teBJP1KhEzJfT2OVnydM1EYPzcQk+ZjpAeHwmRectRPigEwEDb06l79YQLk0E8zuQ2oGgEApKyR35eVP31RuvnZOAz6uSKJFkCIOnkPplno1HcqBVuifC3cRkTGKZYI1Kz1ah8hMZOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eug6At+W; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eug6At+W"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so9519345e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784468; x=1786389268; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0+Dtt+qJBPTI4+fmnWaoabqJejFJgvFqXohqyKLWEac=;
        b=Eug6At+Wqb+TIi2YmKUtYOhSlvxGTBqdzwUZp3MX69StmBo/JOU3E84uRE3RdB3Q5I
         jWiPMB5z5LdD+Mjr+bC8YnOIquqRYRkT9T3N7nzlC66wdKPitcyr6ehmlVtVMPltOy//
         v7cdCJbe2t2VVI4/EFzofHuN4W2XFErQ5T6vjb7JM9j/5kAOnOfWqoxeS9Hb1CR81Xnh
         2WbjpITUioyXB/NyvI2knE5fAU7mkQ6UQ0Dl9MtOdyov7EbOAsy88WpkoKZP0WMlngP0
         OyRNxWx/b24BBe+zHVhyQbNHtOG60WRwRLVTzakNZPX3L/L2vyr67uuaDIsYql4t1tQH
         cPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784468; x=1786389268;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+Dtt+qJBPTI4+fmnWaoabqJejFJgvFqXohqyKLWEac=;
        b=AHZsBenrkFHZGfU2f/aLItudkyk785ZancSTsCKM2/PnyUAyO0Fkzdkklpxp/vLAVX
         26pGG/GrsTKTLdpTVJLIFffH9+LKGEEOujI6zAH+xejOf+grW/IJmPiT5M1g0aHiyLgw
         pXY/whRAnHsp7Ku/vKnTEzKLDYUZWC96zLgBA92oTuVGVZSbsXaDgZgvgf1OS2HT5Fr2
         rXeE2U87eV5MCaqseOgl6QBF1xQwU6ZwyaOxvSnBYsXBCN7Bco/n8wcix2GLPFLUw0Aj
         3a0bMNyxPjeRENkzDxDYn8Y1f5nXMmCY8gdOhhWyXYKkpws4wjYA2okSdIRetHvl5Y2/
         sU8w==
X-Forwarded-Encrypted: i=1; AHgh+Ro3JCx65lzIWvwg5JOZgzOmjz70EDzIsXxNQJVhw8sR6BQjYlIzLs7ek78r2RCRHv6xA7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNbpHPzji9DG6S9dBRI7jeC0WiEDOnJFFHCYUXX18R2sJtOC7
	ngsunRbBoLRc0fKw1ZvndV5rn/NKI0mdfGdlD0q9s71MYdEmswZ0Pktm
X-Gm-Gg: AR+sD137jfz2E2rCts5VY2Tslog8xAc2rX0pHP6JNesA+0a1E0O/kPlourZuri9GCjG
	/OzqJX7WjCPPgyOlDloMvWBRmdaPHuDV6Dh6DrFHExpKBx2iwyFBWCKn4AKBA+FPuJCH1WGJM14
	uzBqVlmWsopYtOhkmZYTsFrUgUSclr0CzFCqwerz+pY2zbhJ3UYkRbmIbKwB1RW6YyFB5+Wb6r2
	nxfjELFSlxWfkmMEWqC9rTBkqZdNca3NvuVPfq4KDlYKFtZAoLKb5cJXv4ho0WVuuvMtG4nQ0HF
	sJQ3WfC33g3ELw5qGwtyhLMYxatwv8Lfu37JuvAMXUzrdhg6CNAlynGkz/Yq+6XAms1wWqnZVe/
	a4sgMuD1mX//A4KVOR1eNBazxT3o0w014woiuZQbcvlD+vrD4ZPrltdMqx6K1YBGE0W0xFBl18f
	zU9W5JR1wMX4sOOm9j+fkjr55ME9VVkjzWjFIV6Yr/PS9QwyYJQWT5WvuZtBXYf5G5qkV2+UAZ3
	qJXPjC3gq1SL6NZ/7fcf3Wi+C4Ih63DEpp/7IDOYK0+zvf6g5+soEIE7kKXitpbsO+ZHarZI4Vf
	xXXodQviD7/KJYGndgLMC0vaOzA55PvSpatJwg==
X-Received: by 2002:a05:600c:8b33:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-4980c66c798mr289237635e9.7.1785784468115;
        Mon, 03 Aug 2026 12:14:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fef72esm19303915e9.15.2026.08.03.12.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 21:14:27 +0200
Message-Id: <DKFJREUTB93P.18LYK6Z4GHBUC@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, "Pu Lehui"
 <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Song Liu" <song@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Pu Lehui" <pulehui@huawei.com>
Subject: Re: [PATCH bpf v4] bpf: Fix UAF when reading prog type in
 bpf_mprog_link
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260728074223.2831773-1-pulehui@huaweicloud.com>
 <da7357fe-9d64-4e9c-a0f6-573a9761c8b2@iogearbox.net>
In-Reply-To: <da7357fe-9d64-4e9c-a0f6-573a9761c8b2@iogearbox.net>

On Mon Aug 3, 2026 at 9:00 PM CEST, Daniel Borkmann wrote:
> On 7/28/26 9:42 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In bpf_mprog_link, the code currently allows a user to pass an abnormal
>> non-netkit or non-tcx link via relative_fd. If a concurrent
>> BPF_LINK_UPDATE is performed on this abnormal link before dereferencing
>> link->prog->type in bpf_mprog_link(), it can trigger a UAF issue.
>>
>> CPU0                                      CPU1
>> netkit_link_prog_attach
>> bpf_mprog_attach
>> bpf_mprog_tuple_relative
>> bpf_mprog_link
>>    /* non-netkit or non-tcx link */
>>    link =3D bpf_link_get_from_fd(id_or_fd);
>>                                            BPF_LINK_UPDATE on relative l=
ink
>>                                            ...
>>                                            old_prog =3D xchg(&link->link=
.prog, new_prog);
>>                                            bpf_prog_put(old_prog);
>>    if (type && link->prog->type !=3D type) <-- trigger UAF
>>
>> The reason for the UAF is that each subsystem provides its own
>> protection for link->prog. Since there is no cross subsystem protection
>> (if not considering the RCU of prog tear down), dereferencing the prog
>> of an anchor link that does not belong to the current subsystem is not
>> safe: it may have been freed.
>>
>> To resolve this, we access link->prog under RCU protection to safely
>> fetch the pointer and guarantee its lifetime during the type check.
>> Meanwhile, add a comment explaining that when ptype =3D=3D UNSPEC in
>> bpf_mprog_detach, it acts as a wildcard.
>>
>> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi=
-progs")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>> v4:
>> - Access prog->type under rcu protection to simplify the repair logic,
>>    and let unconditional detachment make sense when the bare prog or
>>    link->prog being detached is NULL.
>> - Add Reviewed-by tag by Emil.
>> - Separate from patchset [0]. (Andrii)
>>
>> Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@h=
uaweicloud.com [0]
>>
>> v3: https://lore.kernel.org/bpf/20260722072326.1545677-3-pulehui@huaweic=
loud.com
>> - BPF_F_LINK flag set means the relative id_or_fd is a link, not the obj=
ect being
>>    attached. We can not get the link while attach a bare prog with relat=
ive link.
>>    So passing expected link type from callers of bpf_mprog_attach/detach=
. (Sashiko)
>> - Add comment to explain that why ptype =3D=3D UNSPEC. (Emil)
>>
>> v2: https://lore.kernel.org/bpf/20260721041048.1394085-3-pulehui@huaweic=
loud.com
>> - Improve commit msg for patch 2. (Amery)
>>
>> v1: https://lore.kernel.org/bpf/20260720134547.1289964-3-pulehui@huaweic=
loud.com
>>
>>   kernel/bpf/mprog.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>> index 1394168062e8..af3e6c1c6a1f 100644
>> --- a/kernel/bpf/mprog.c
>> +++ b/kernel/bpf/mprog.c
>> @@ -10,6 +10,8 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>   {
>>   	struct bpf_link *link =3D ERR_PTR(-EINVAL);
>>   	bool id =3D flags & BPF_F_ID;
>> +	bool type_mismatch =3D false;
>> +	struct bpf_prog *prog;
>>
>>   	if (id)
>>   		link =3D bpf_link_by_id(id_or_fd);
>> @@ -17,13 +19,20 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>   		link =3D bpf_link_get_from_fd(id_or_fd);
>>   	if (IS_ERR(link))
>>   		return PTR_ERR(link);
>> -	if (type && link->prog->type !=3D type) {
>> +
>> +	rcu_read_lock();
>> +	prog =3D READ_ONCE(link->prog);
>> +	if (!prog || (type && prog->type !=3D type))
>> +		type_mismatch =3D true;
>> +	rcu_read_unlock();
>
> Hm, what about progs under rcu_read_lock_trace cases, wouldn't the UAF
> still be there?
>
> Even though the diff is smaller, I'd kind of lean towards link->type
> testing since this addresses the underlying issue and avoids touching
> the prog completely.. do you want me to look into it and also add a
> BPF selftest to it as patch 2/2?
>

I think Pu's implication was that an RCU tasks trace GP would imply RCU gp,=
 thus
using RCU read lock for protection in both cases would be sufficient for th=
e
link's free path to wait for this reader. More context is available in [0].=
 I do
think this merits a comment for clarity, even in [0] I explicitly commented
about it everywhere even when it felt unnecessary.

I didn't closely follow this set of fixes (those in addition to this) yet b=
ut in
general, we also need to be careful about tracepoint BPF links. Those will =
only
wait for SRCU gp, which is not implied for rcu_read_lock() etc., so will ne=
ed
their own distinct critical section. The fix pertaining to that was in [1].

  [0]: https://lore.kernel.org/bpf/20260407162234.785270-1-memxor@gmail.com
  [1]: https://lore.kernel.org/bpf/20260331211021.1632902-2-memxor@gmail.co=
m

>> +	if (type_mismatch) {
>>   		bpf_link_put(link);
>>   		return -EINVAL;
>>   	}
>>
>>   	tuple->link =3D link;
>> -	tuple->prog =3D link->prog;
>> +	tuple->prog =3D prog;
>>   	return 0;
>>   }
>>
>> @@ -343,8 +352,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>   	if (!bpf_mprog_total(entry))
>>   		return -ENOENT;
>>   	ret =3D bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
>> -				       prog ? prog->type :
>> -				       BPF_PROG_TYPE_UNSPEC);
>> +				       /* Use UNSPEC as wildcard when prog is NULL */
>> +				       prog ? prog->type : BPF_PROG_TYPE_UNSPEC);
>>   	if (ret)
>>   		return ret;
>>   	if (dtuple.prog) {

