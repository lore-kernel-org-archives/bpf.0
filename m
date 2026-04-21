Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCC3A5E69;
	Tue, 21 Apr 2026 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763220; cv=none; b=b7Ln4mvMVWnz8SeG7pW2jty4s9wVRqzxq2/yQfkl1qk1C1xmTqe5aatIXZQjmO3+rXYnHwnyzFGaVyciGEWfe9XZzDKifhFFwlE5rhJBY1spHJi9HcxNPNfZCPrGkMCB0ylMjZlEsMVU+Hz3RYcSg/1vpinAK1wXnYxe1nh+ygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763220; c=relaxed/simple;
	bh=mNosDArApEhR/sEjt6xuw/c6Atp9IN4OF4EzpiaVe+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIoLVaVGMySzcr6ilYuZlY3/b/9BBOOhUUCfacb5avlPDoQtNliFjVoQIaDxCa/MvaG1sPJu/SL1edTCl6wF1DZtSaH733akC6YLVzBKnizDjSDJXxN8MObQh12trzXd2Qf58xBFzKPrkL0PhOpyP8pQWBrIPb3l1Qna5wXFhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WnPPXhcx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WnPPXhcx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ng
	RzgCjuXo48vslvABagpJ43ZvHZTy3kJBFKV9GRc+E=; b=WnPPXhcxaxe0R7cSDv
	d2kYJNwpMcTeSA/2hUJUnKRx9FOJKXto9V05WP4Dpfu3WPP9i6dRnJymKf3uD+a2
	0Ko+p+2HGAwtdVO6wYddcokaGZlCtukLnfMLdnZ2BtOYbE51Z0K3Z6fpZwusaPKq
	KmIVeeu79wpAWNVzZGDq0/tEg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC330MDQedpAr6+Aw--.8329S2;
	Tue, 21 Apr 2026 17:18:59 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: yangfeng59949@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mattbobrowski@google.com,
	memxor@gmail.com,
	menglong.dong@linux.dev,
	song@kernel.org,
	yangfeng@kylinos.cn,
	yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Tue, 21 Apr 2026 17:18:59 +0800
Message-Id: <20260421091859.256592-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260411163556.8567-2-yangfeng59949@163.com>
References: <20260411163556.8567-2-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC330MDQedpAr6+Aw--.8329S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry5CFy3tFWDuFy3Gw45ZFb_yoW8Xry5pa
	yUJF9Fyrn0k395JF4kAws3Zr1S9wsxGw45Aws0qw1qyFyUtr48G347K3yavr1rCr1UKw1I
	qFsIyFsxCF4ay37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUOTm-UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0ASlHmnnQQTakgAA3s

[...]

Issue Regarding BPF_PROG_TYPE_EXT Programs Bypassing Validation Logic:

__attribute__ ((noinline)) int B()
{
        return 0; /* Valid return value */
}

SEC("fmod_ret/security_task_alloc")
int A()
{
        return B();
}

SEC("freplace/B")
int replace()
{
        return 1; /* Invalid return value */
}

This method can verify whether the return value of freplace is legitimate
by using env->prog->aux->dst_prog->aux->attach_btf_id.

However, this approach will reject legitimate programs if the return value of
the original program does not come from the replaced function (as shown below).

__attribute__ ((noinline)) int B()
{
        return 0; 
}

SEC("fmod_ret/security_task_alloc")
int A()
{
        B();
        return 0;
}

SEC("freplace/B")
int replace()
{
        return 1;
}

I have not found a proper solution to this issue.



target.bpf.c:
__attribute__ ((noinline)) int B()
{
	bpf_printk("--\n");
	return -2;	
}

SEC("fmod_ret/security_task_alloc")
int A()
{
	int i = B();
	bpf_printk("return: %d\n", i);
   	return i;
}

freplace.bpf.c:
SEC("freplace/B")
int replace()
{
	bpf_printk("freplace\n");
	return -1;
}
In addition, the log output from testing the above program is as follows:
cat /sys/kernel/debug/tracing/trace_pipe 
          attack-5370    [002] ...11  4379.086626: bpf_trace_printk: freplace

          attack-5370    [002] ...11  4379.086656: bpf_trace_printk: return: -2

Strangely, the replacement program is executed, but the return value still originates from the original program.


