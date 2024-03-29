Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33221107A8
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694062; cv=none; b=EkF5K+UeHCG4xfyo9AYImif9AMKy54o4S/xxV0KluRs1T8ldNJB5fpXrxOnCZocTIUFVY0jfOIXTdyYRzW4Yng4gbEmHxT2xNv9hwN+rNaKPJo+Iy32D2pQUrasTwnJpqvvcLwMQKkHCtYvnYbhmGbL7ICoKBWUvZktmgmu/wAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694062; c=relaxed/simple;
	bh=InZLmeQ3D9yy+muH32Y9kpVlOGSmf5QONrD2IJR4d/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIYrcBSmlizHneF5ai/PFyYHyKABONrDszIuNaDsKHpte+T+C2ldKCvQznCPU67P4hIx94CJF0Oh+QM7Ab3vMND3r6wHH5Pl235v0MfuZ6bc/J4JdD95TBLb8Tz8MBB3q5mFk+zlbQU52LA6LjJgzaMIstwAUp6wC2PD+rxj4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T4aeuhhb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T4aeuhhb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so313041366b.1
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 23:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711694058; x=1712298858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ma+vtqvSlr0gujBxsYgzn0X6HBjLP9HhEs0oHeEYF4=;
        b=T4aeuhhbPtsoYaHdWuoJfZ8F3X8nbY50dfgFPit6OCc6XqJDw7ndHJBqT7WIGiWizK
         umClgGSBSI2grtI9/26hSI3YWJRAX2GGNxbI0FWfN83QgnStCaq4ZFZJ+m6B+FIIlZdu
         Lh+1kVaEd+2t1WNC41YjhJaeHWH9B9qvFIOtd8Rd8+1ifTfIggS8YmpfzjrOxv4HSz2T
         XTlgD6rrCQmClg8zNyLpSeXlTOLAPGBGnqcQ0Tejv/y1E5oY0JxQb5d7v2hc3JatuFjl
         NV5gg6VUrl8OWPjNpw7gkJDe6jLXFSyK5ipteo7EytMGNgrRYGiaCR2occiH3L+0VU3l
         ZC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711694058; x=1712298858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ma+vtqvSlr0gujBxsYgzn0X6HBjLP9HhEs0oHeEYF4=;
        b=dFfzTYtZIDwjhcMgn29wHm6ckcqkjg+xlhAIDIihpTqU8WYg74hpcveH0LeaefQ5Nn
         1bQiK3MuFG9cV55orDtdavT+fVrEqbhKED4t9mtqDGkt09jHrx5CV+xp4MkuwtB5nMTA
         6BgCCGuSZX+K8pCOR3ilBl/bJOOSM/3XtEsPTkGmAOOgThOTU+ai18o2YCEwH5dzryvr
         FNvG5tbQ+QsxcN2BC2mRfQJiRprTXiN8U5ycH39aTL7+n5vHU+pBZCzxghE45XMQrrZP
         zlD5CW2EP1vvf01esG2P9MOrDeF+LzT7WXFRRvFc1aDvcvaFLxibwemHGGwAiq6A/WeR
         ofHg==
X-Forwarded-Encrypted: i=1; AJvYcCWtbVqHL6LSbKQhzMiztHf2UYxZW9MxpsLm90XiuUaguHGzm1NNjAZzSPkCSW+DLNIFrzgYykGSGQzZl+/uR1Jg+e0c
X-Gm-Message-State: AOJu0YzX54qAswxckNjUgxp1VOlJgOUKu5m+J5dvYT8b357cjvZnTt3u
	1OV9zJ8HnqhiZV/q0Ef+BhcBGsyNYqKTaJelonrfYY6FsV70KGW3kItWjB5Lydw=
X-Google-Smtp-Source: AGHT+IH1VcKzFcTm54dsRZaQxbNj3vOYMOpgXud+tLc/JjE1XgeD1l3eoB/yHtw3XXtCfSLCUPRrGQ==
X-Received: by 2002:a17:906:d112:b0:a4e:3910:72fd with SMTP id b18-20020a170906d11200b00a4e391072fdmr353448ejz.20.1711694058444;
        Thu, 28 Mar 2024 23:34:18 -0700 (PDT)
Received: from u94a ([2401:e180:8810:bf68:a132:2657:d239:3e12])
        by smtp.gmail.com with ESMTPSA id bw17-20020a170906c1d100b00a46b4544da2sm1558477ejb.125.2024.03.28.23.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:34:17 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:34:00 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu, 
	sn624@cs.rutgers.edu, sn349@cs.rutgers.edu, m.shachnai@rutgers.edu, paul@isovalent.com, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value
 tracking
Message-ID: <7s76qe3ucxiyjctbztrpuevwu4hxeogrm7bbarewjbu6bhsyfr@m4dkjap7hiyy>
References: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>

On Thu, Mar 28, 2024 at 11:01:19PM -0400, Harishankar Vishwanathan wrote:
> The scalar(32)_min_max_and/or/xor functions can exhibit unsound behavior
> when setting signed bounds. The following example illustrates the issue for
> scalar_min_max_and(), but it applies to the other functions.
> 
> In scalar_min_max_and() the following clause is executed when ANDing
> positive numbers:
> 
> 		/* ANDing two positives gives a positive, so safe to
> 		 * cast result into s64.
> 		 */
> 		dst_reg->smin_value = dst_reg->umin_value;
> 		dst_reg->smax_value = dst_reg->umax_value;
> 
> However, if umin_value and umax_value of dst_reg cross the sign boundary
> (i.e., if (s64)dst_reg->umin_value > (s64)dst_reg->umax_value), then we
> will end up with smin_value > smax_value, which is unsound.
> 
> Previous works [1, 2] have discovered and reported this issue. Our tool
> Agni [3] consideres it a false positive. This is because, during the
> verification of the abstract operator scalar_min_max_and(), Agni restricts
> its inputs to those passing through reg_bounds_sync(). This mimics
> real-world verifier behavior, as reg_bounds_sync() is invariably executed
> at the tail of every abstract operator. Therefore, such behavior is
> unlikely in an actual verifier execution.
> 
> However, it is still unsound for an abstract operator to exhibit behavior
> where smin_value > smax_value. This patch fixes it, making the abstract
> operator sound for all (well-formed) inputs.
> 
> It's worth noting that this patch only modifies the output signed bounds
> (smin/smax_value) in cases where it was previously unsound. As such, there
> is no change in precision. When the unsigned bounds (umin/umax_value) cross
> the sign boundary, they shouldn't be used to update  the signed bounds
> (smin/max_value). In only such cases, we set the output signed bounds to
> unbounded [S64_MIN, S64_MAX]. We confirmed through SMT verification that
> the problem occurs if and only if the unsigned bounds cross the sign
> boundary.
> 
> [1] https://sanjit-bhat.github.io/assets/pdf/ebpf-verifier-range-analysis22.pdf
> [2] https://github.com/bpfverif/agni
> [3] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12
> 
> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

I'd suggest adding a fixes tag as well. This seems to go all the way
back to the signed/unsigned split.

Fixed: b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")

Otherwise

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
