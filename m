Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0243492E25
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941727; cv=none; b=rDnwpEZl6BAKKy+yc3RTmkEDhS3Y4nCO2Pi12l3965UhRh5MIeN/km1fiHc+0WNNw2RC/wE/vH4qqGLMR5hXqKzuzR/kG+lMVYQLg4YskWm+KH5TvKjWtYZkVV6WTB7QD2iBnjsJT6RQizjgT7OEpoUfAUDoGKsd2en3p9IW/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941727; c=relaxed/simple;
	bh=gAY+ry7XQppx5kZcg+BfzcVwDqxF38v68qrWhv2EpEU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Ih71oMVe+75p+RnhqpJpNqxosieULtrQ6xIDh+rZQrwct7UDpjO+MknXIljueeJPFMW/kNzHnBJdKzvsjdPJDIxF0QVEGDdkoDJFvpOcL1djiaPio6xJ7fzawyd3CgNL0G8MV9zgcHGEGyTCcXtjTnHr7T8VV/39R66o6o4RGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeyZIhmU; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeyZIhmU"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cadbe09cso2336463a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790941724; x=1791546524; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDgCZ93FbbC+h+9QAZpC0c3CaTDV4NHqwfDJ+8l3w7I=;
        b=MeyZIhmU8tcw6SYtV+1UZ7tSerG+sxuHQGu95Sf+jXbAr1jEANi1Xr2UvlE2O8dFCC
         Kz4XzfQuSc3KIwWpsVO1Wp9OmjeYf+k2zVFqFV8MrniXv/Iv8UCfKoVfgmpUA3BuiRNo
         E09LSomNq7IqB2WCn+1NYu8sFOkvU0Cu6beoCzkTV3AHfDKdEtalVaFOtKnZkVt+FvBt
         TdkVI6itaXRa85ogpErUJnSIghBnEdXTd3G62zvw8C3M2iygDKn2y0J1J0hsAnGP9hT8
         3SVS+eFmQ2NIyY/3qTsvtmqitlyjb/IelUbO2q1DHTFsAfgRgFm+mHLNtvYT7EJfslZ4
         pFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941724; x=1791546524;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDgCZ93FbbC+h+9QAZpC0c3CaTDV4NHqwfDJ+8l3w7I=;
        b=hSowzQ2DCTKyD9khgrXqD3ugKGriRfGNoT5fqSN8C5i/jynclBf2txWK8QvwgtFpD6
         x4Vc/h09TEqby3ybik0BQf/eOVhJ55CqiRvOUCBQUdn3UXBFZhMCj+uDXGH4iop6k7hu
         vmZlaKocN5lmSeI2lSSFNcRleLGhHhBV67d/om6xouy/PkQ/vsOtFqbvsP4i2o3MegwB
         7CmEMIFR2wCtNwQEzNZCk6UYBOh5BVqd8EekKXpZQpy5hmrLoDETLzVXNdftfTmfivNl
         DHDqkMx2kY32kQTZtU7NMU/MQDaTk0KZV2bs4tsJc+lOjf0LEYKghoOPzH2/CP80fr08
         GjfA==
X-Forwarded-Encrypted: i=1; AKwUvBy1IayGXBMh2l5C4rPJJ8NUQTN6vx93jiEsTRv7lwy59QZLJmRNizl9tD/3tAAtEA2TPTs=@vger.kernel.org
X-Gm-Message-State: AFuF++nYUySxl4WJyuhNfdYlIggcK4UWxI988j/c6Kwv48eAhG3Ei6uV
	xPzxdTOoPW0kYs2UqTVC2EEiuSws5fzSWKggy+/fHCVEXxezj3Xiq9ke
X-Gm-Gg: AYBFou2hSiTvoiuDgQoSemQt5SwYY8DWIVUAERIsraPYazjbWs7jb7g0gMPmmmXSg8C
	tGWCnA0mtjEbuRw/n1Yg5q7Uk8ZiakhYTtVV3YDU+Ov4rXphe/u13kH7cVX3J+9u5zLoRl9v+ho
	mPtLOtVT1Jc/Z/d0cCZSXnGjxHjFENa9vUq5wK2t0wwqYIpybEsbjFaYwLiQsebvPzfy1wjItjD
	vadiImAWGuNJgwfQ/oBXO1VB6nLihag4l6JhQxUL1VWXbpShs24lucxUwGx9TzybiCOnkcXiLB4
	30u8OXohYA+BMoBBOI7vrl52zcPfO4THeOWE14DUPcV79AXa6QC+BG+DSvS+lYPML3XKlijaAF1
	qFm5XyyjPybh4bhu5J2DH6somaM6dvaqYiq4q7B4Wg/PbExiatSPlBYnpIKHcfTCg8bpu1PR8rb
	khu28XGU/VVJw4H8pm6FjWl7RaOhUiLUeOc6jESJd9d6ErFfSCW6Ns1IgjMxYqlfRlE2bjjlnSV
	Nz6995Cyl8Ov39ldeDe/3iFa7ySgat5kpljsNw7+1SVNW0On7vuD34NOP7NijOeSf4hhlHKVmrs
	0Jc=
X-Received: by 2002:a05:6300:210a:b0:3e0:b937:8844 with SMTP id adf61e73a8af0-3e0bd199342mr2548048637.44.1790941723843;
        Fri, 02 Oct 2026 04:48:43 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247dbcsm743396b3a.55.2026.10.02.04.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:48:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:48:42 +0000
Message-Id: <DLUBUT40BBOG.1L6QS7A8CIE79@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Quentin Monnet" <qmo@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Christian
 Heusel" <christian@heusel.eu>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Sami Tolvanen"
 <samitolvanen@google.com>, <linux-modules@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, "Arnaldo Carvalho de Melo"
 <acme@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ian Rogers"
 <irogers@google.com>, <linux-perf-users@vger.kernel.org>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 <linux-input@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Hazem Mohamed Abuelfotoh"
 <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>, "Martin Pohlack"
 <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: take the vmlinux BTF from the
 btf_vmlinux module
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261001225214.12351-5-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com> <20261001225214.12351-5-wanjay@amazon.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 10:52 PM Jay Wang <wanjay@amazon.com> wrote:
> +	err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
> +	if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && err < 0 && bpf_btf_vmlinux_retry(cmd, misses))
> +		err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common),
> +				size_common);

Running the command twice when it failed and a global counter moved
is not going to fly.
Missing BTF is not always an error.
With =m and BTF not loaded yet take
  int prog(struct xdp_md *ctx)
with func_info. That is everything libbpf loads.
do_check_common() calls btf_prepare_func_args(env, 0).
find_canonical_prog_ctx_type() returns NULL, btf_is_prog_ctx_type()
returns false, the arg becomes ARG_PTR_TO_MEM and
func_info_aux[0].unreliable is set.
The prog loads. err == 0. No retry.
From then on freplace of that prog fails with
"Cannot replace static functions" and fentry/fexit see its args
as scalars, even after BTF is loaded.
With =y both work.

That is the only reason why "a socket filter does not load it".
In v3 such prog loaded BTF.
systemd built with BPF_FRAMEWORK loads
  int sd_bind4(struct bpf_sock_addr *ctx)
from manager_setup_cgroup() at every boot.

The result of the verification cannot depend on who touched BTF first.

bpf-ci is right too. The first run writes into uattr.

It's starting to feel that this is dead end.
So much complexity to save few Mbyte.

pw-bot: cr
