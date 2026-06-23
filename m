Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4123D092E;
	Tue, 23 Jun 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211439; cv=none; b=kuQdLUI/FyW+/Hm8Ea3iza/OMnihb7K/D5AWfT9sJtC0XitIinxy8JV/vt6YXtrStc4WfIX72KcDmDv9hPXPlLJhuZYoq2PS0LKgeze0kNTI9H2hK9izezwgN8WauUlY08OXeaPTG1QP5eu3RMzzRu3HbBKOQ+qkr3sA7Vmg+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211439; c=relaxed/simple;
	bh=VUVe4/SjGaTfCsH8K/XuqCMt6jXdc7XiVSxyqnlFUQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ugfOmUq+877XzyzOWBHrqWAY/AXgeqOpLlEOLk+XcQKZpj3WW2cLPLI22dUk6+NZg9JYM4WZ4Nv2oKMeNWyZbwaKNvd2WSqqy82p6WfMP2t4b9NIsYnlpzxzXvgTgQNXPT8h1O2E6YlyFwvUNU2WHtIAqH+GilKHy9SS078l8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=UuPv0gz3; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="UuPv0gz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=BEzK54WsZZQQY6H6ksb7bS3O/Ub4RxBDB18ifaBNHbI=; b=UuPv0g
	z3dYeQfu3LX69+Y0K/QL9x29DQFGTPK4i/4JsOZ4/4WTGFPRE0Qyo6Ial6J0hONW
	6kG3MLo45P3BlO1EkQIWZR9QuKfgpk4Az0uQmfXHMqGIy/MqrT+Tob0oYVwZkFI5
	zypAnNyBLVOtJfPqvEd9Vc3ew6cE2NPEPy+mE=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQAHU5BbYzpq5jGnAg--.34960S2;
	Tue, 23 Jun 2026 18:43:39 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v2 0/2] bpf: Mask pseudo pointer values in
 verifier logs
Date: Tue, 23 Jun 2026 18:43:37 +0800
Message-Id: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFljOmoC/32OQQ6DIBBFr9LMumOARiJd9R6NC8RBaVo0AsbGe
 Pei7rv8mfffnxUCTY4C3C8rTDS74Aafg7hewPTad4SuzRkEE5JJrtAyjvyGY6DUDthEmwE0esR
 mtFhWpVUVaSNkBVkxTmTdcuifsAOelgj1eQmpeZGJu31nexfiMH2PT2Z+NM5Rwf6PzhwzoUpmp
 bIkmXl8tHuHIgbnuz7pgtpUGA/1tm0/xme2jPAAAAA=
X-Change-ID: 20260619-f01-13-pseudo-btf-id-cap-bpf-585f98eac268
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Hao Luo <haoluo@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782211420; l=2147;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=VUVe4/SjGaTfCsH8K/XuqCMt6jXdc7XiVSxyqnlFUQg=;
 b=hun+HWPtare31FaVrlemv/0Zadg54cOSV+aOhzK11JW8o0QkbCuIlV1X7RxpOfms24LY5Gg6P
 diMZPfDpvDXDK7StjyBNRwHRqIKkdbTCgy77k0NocYtixXo21gwv8kE
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQAHU5BbYzpq5jGnAg--.34960S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW8CFykJrWDuF47ZF4fXwb_yoW8tr4rpa
	n7Gr4avr48Aw1kCanIya42kF9YqasYkr13GrnrJw15AFn8XayUXwn2va1UWr1Yk3y0kw1a
	yFW3X34j934UXrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wrylc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCdgAUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgEHA2o6NDluQgAAs2

Verifier log printing already hides ldimm64 immediates for map FD and
map value pseudo sources when pointer leaks are not allowed. The same
print path also sees rewritten immediates for BPF_PSEUDO_MAP_IDX,
BPF_PSEUDO_MAP_IDX_VALUE, and BPF_PSEUDO_BTF_ID, but those sources were
not included in the pointer classification.

Extend the existing masking so all pointer-producing ldimm64 pseudo
sources print as 0x0 when allow_ptr_leaks is false.

Patch 1 extends the disassembler-side masking.
Patch 2 adds verifier selftest coverage for pseudo-BTF ksym logs.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Changes in v2:
- Replace the CAP_BPF gate with verifier-log masking in print_bpf_insn().
- Also mask BPF_PSEUDO_MAP_IDX and BPF_PSEUDO_MAP_IDX_VALUE immediates.
- Update selftests to check masked pseudo-BTF ksym logs.
- Link to v1: https://patch.msgid.link/20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn

To: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Hao Luo <haoluo@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Nuoqi Gui (2):
      bpf: Mask pseudo pointer values in verifier logs
      selftests/bpf: Cover pseudo-BTF ksym log masking

 kernel/bpf/disasm.c                                 |  5 ++++-
 tools/testing/selftests/bpf/progs/verifier_unpriv.c | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
---
base-commit: a3847994b4d20c0701ccc54fe110920ea78e73dc
change-id: 20260619-f01-13-pseudo-btf-id-cap-bpf-585f98eac268

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

