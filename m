Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B4313534;
	Tue, 24 Mar 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333828; cv=none; b=EwFQVmB+er+YPV5tDFkcgYzpFh0CtVB35kGLncdjkc/a7QbYCHj1NJOqPXc780DMU3ilbc2Yn6SluOau+Npg1NDfbe74eRb+FnIkVf+4f1PEmDrljyXBl9itkY9aWIKx6U/SgYQWgOc+CrPWmOdXnB2NSLoVp++Tk7v+aRG9arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333828; c=relaxed/simple;
	bh=xlN3ubk5aj6JoF2vHLdGiQLFRkP3ZYIcbsd2M7kf2to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r06SKhHLABB2lA4vdKw63Cwq/pReQcIXEH6/GbwqtvORr0uePKjlBpA5IgqkU7Yt8TrHgEhEzDyfi17ZE2UPolj1N4uVgpZCnYgbx9fncLi3gRtHVoKgUV1cXPg5T3n/S1H5dkdMy4U4V7MXBexgQ3i8j71OqFPt+e3E88Ve5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [183.157.161.222])
	by mtasvr (Coremail) with SMTP id _____wCHuexpL8Jpd7VMAA--.14579S3;
	Tue, 24 Mar 2026 14:30:02 +0800 (CST)
Received: from localhost.localdomain (unknown [183.157.161.222])
	by mail-app2 (Coremail) with SMTP id zC_KCgDXR81nL8Jpt5gbAA--.3608S2;
	Tue, 24 Mar 2026 14:30:00 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Shenghao Yuan <shenghaoyuan0928@163.com>,
	Tianci Cao <ziye@zju.edu.cn>
Subject: Re: [PATCH bpf-next] bpf: Drop redundant CONT_JMP alias
Date: Tue, 24 Mar 2026 14:29:57 +0800
Message-Id: <20260324062957.2850-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAADnVQKgyDkH1xcrQTD2RgTz5k+NAwxbmXFnJEPosvCZH6J5NQ@mail.gmail.com>
References: <CAADnVQKgyDkH1xcrQTD2RgTz5k+NAwxbmXFnJEPosvCZH6J5NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDXR81nL8Jpt5gbAA--.3608S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?iZE8OAXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083gQkFDeLwlqL5lzEaRMYLHIL35aHLg90bYIEk44IbKOzsnRPZf0sjEpCD9KVvWslA0Mc
	MclT0gJz5rPLUp4piIzN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48Icx
	kI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

On Mon, Mar 23, 2026 at 08:22:52AM -0700, Alexei Starovoitov wrote:
> It was like this for years and can stay as-is for historical reasons.

Thanks for the review and the explanation.
I understand. I'll leave it as-is and keep this in mind for future cleanup patches.

Thanks,
Tianci

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>

